// ignore_for_file: unnecessary_new, missing_return, duplicate_ignore, prefer_const_constructors, avoid_print

import 'dart:io';
import 'dart:convert';

import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/provider/users_provider.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:app_delivery/src/utils/my_snackbar.dart';
import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientUpdateController {
  BuildContext context;

  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  Function refresh;

  PickedFile pickedFile;
  File imageFile;

  ProgressDialog _progressDialog;

  User user;
  SharePref _sharePref = new SharePref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;

    this.refresh = refresh;

    this._progressDialog = _progressDialog;

    _progressDialog = ProgressDialog(context: context);

    //Se obtienen datos del usuario
    user = User.fromJson(await _sharePref.read('user'));

    //Se requiere que el usuario tenga un token valido
    usersProvider.init(context, sessionUser: user);

    nameController.text = user.name;
    lastNameController.text = user.lastname;
    phoneController.text = user.phone;

    refresh();
  }

  void backToLoginPage() {
    Navigator.pop(context);
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }

    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galerryButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.gallery);
      },
      child: Text('Galeria'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(MyColors.primaryColor),
      ),
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.camera);
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

  void update() async {
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text.trim();

// Validando que el ususario inserte todos los datos
    if (name.isEmpty || lastName.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    _progressDialog.show(max: 100, msg: 'Espere un momento....');

    // ignore: unnecessary_new

    User myUser = new User(
        id: user.id,
        name: name,
        lastname: lastName,
        phone: phone,
        image: user.image);

    Stream stream = await usersProvider.update(myUser, imageFile);
    stream.listen((res) async {
      _progressDialog.close();

      // ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('RESPUESTA: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.message);

      //Toast
      //Fluttertoast.showToast(msg: responseApi.message);

      if (responseApi.success) {
        //
        user =
            await usersProvider.getById(myUser.id); //USUARIO OBTENIDO DE LA DB
        print('Usuario obtenido: ${user.toJson()}');
        _sharePref.save('user', user.toJson());

        Navigator.pushNamedAndRemoveUntil(
            context, 'client/products/list', (route) => false);
      }

      if (responseApi != null) {
        print('RESPUESTA: ${responseApi.toJson()}');
      } else {
        print('LA RESPUESTA FUE NULA');
      }
    });
  }
}
