// ignore_for_file: unnecessary_new, missing_return, duplicate_ignore, prefer_const_constructors, avoid_print

import 'dart:io';
import 'dart:convert';

import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/provider/users_provider.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:app_delivery/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController {
  BuildContext context;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  Function refresh;

  PickedFile pickedFile;
  File imageFile;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    usersProvider.init(context);

    this.refresh = refresh;
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

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

// Validando que el ususario inserte todos los datos
    if (email.isEmpty ||
        name.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    //Validando Password
    if (confirmPassword != password) {
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    //Validar que la longitud del password sea menor a 6
    if (password.length < 6) {
      MySnackbar.show(context, 'La contraseña debe tener almenos 6 caracteres');
      return;
    }
    //Validar imagen
    if (imageFile == null) {
      MySnackbar.show(context, 'Selecciona una imagen');
      return;
    }

    // ignore: unnecessary_new

    User user = new User(
      email: email,
      name: name,
      lastname: lastName,
      phone: phone,
      password: password,
    );

    Stream stream = await usersProvider.createWhitImae(user, imageFile);
    stream.listen((res) {
      // ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('RESPUESTA: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, 'login');
        });
      }

      if (responseApi != null) {
        print('RESPUESTA: ${responseApi.toJson()}');
      } else {
        print('LA RESPUESTA FUE NULA');
      }
    });
  }
}
