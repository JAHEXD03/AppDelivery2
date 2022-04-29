import 'dart:convert';
import 'dart:io';

import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/models/product.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/provider/categories_provider.dart';
import 'package:app_delivery/src/provider/products_provider.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:app_delivery/src/utils/my_snackbar.dart';
import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RestaurantProductsCreateController {
  BuildContext context;
  Function refresh;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  MoneyMaskedTextController priceController = new MoneyMaskedTextController();

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  User user;
  SharePref _sharePref = new SharePref();

  String idCategory; //Almacenar el idde la categoria

  List<Category> categories = [];

  //IMAGENES
  PickedFile pickedFile;
  File imageFile1;
  File imageFile2;
  File imageFile3;

  ProductsProvider _productsProvider = new ProductsProvider();

  ProgressDialog _progressDialog;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    user = User.fromJson(await _sharePref.read('user'));

    _categoriesProvider.init(context, user);

    _productsProvider.init(context, user);

    _progressDialog = new ProgressDialog(context: context);

    getCategory();
  }

  void getCategory() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  Future selectImage(ImageSource imageSource, int numbeFile) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);

    if (pickedFile != null) {
      if (numbeFile == 1) {
        imageFile1 = File(pickedFile.path);
      } else if (numbeFile == 2) {
        imageFile2 = File(pickedFile.path);
      } else if (numbeFile == 3) {
        imageFile3 = File(pickedFile.path);
      }
    }

    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int numberFile) {
    Widget galerryButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.gallery, numberFile);
      },
      child: Text('Galeria'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColors.primaryColor),
      ),
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.camera, numberFile);
      },
      child: Text('Camara'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColors.primaryColor),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galerryButton,
        cameraButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void createProduct() async {
    String name = nameController.text;
    String description = descriptionController.text;
    double price = priceController.numberValue;

    if (name.isEmpty || description.isEmpty || price == 0) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    if (imageFile1 == null || imageFile2 == null || imageFile3 == null) {
      MySnackbar.show(context, 'Selecciona las 3 imagenes');
      return;
    }

    if (idCategory == null) {
      MySnackbar.show(context, 'Selecciona la categoria del producto');
      return;
    }

    Product product = new Product(
        name: name,
        description: description,
        price: price,
        id_category: int.parse(idCategory));

    List<File> images = [];
    images.add(imageFile1);
    images.add(imageFile2);
    images.add(imageFile3);

    _progressDialog.show(max: 100, msg: 'Espere un momento');

    Stream stream = await _productsProvider.create(product, images);
    stream.listen((res) {
      _progressDialog.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        resetValues();
      }
    });
    print('fProducto: ${product.toJson()}');
  }

  void resetValues() {
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '0.0';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory = null;

    refresh();
  }
}
