// ignore_for_file: unnecessary_new, prefer_final_fields, unnecessary_brace_in_string_interps, avoid_print

import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/provider/users_provider.dart';
import 'package:app_delivery/src/utils/my_snackbar.dart';
import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/material.dart';

class LoginController {
  // late o el simbolo ?, le diceN a dart que nuetras variables no son null y eso respeta a la regla de dart de NULL SAFETY
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  SharePref _sharePref = new SharePref();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharePref.read('user') ?? {});

    if (user?.sessionToken != null) {
      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        //EL METODO pushNamedAndRemoveUntil NOS SIRVE PARA ELIMINAR EL HISTORIAL DE PANTALLAS QUE HAY DETRAS
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles[0].route, (route) => false);
      }
    }
  }

  //Metodo para ir a la pagna de registro
  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    //Trim nos elimina espacios en blanco en los textos capturaos
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);

    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');

    if (responseApi.success) {
      User user = User.fromJson(responseApi.data);
      _sharePref.save('user', user.toJson());

      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        //EL METODO pushNamedAndRemoveUntil NOS SIRVE PARA ELIMINAR EL HISTORIAL DE PANTALLAS QUE HAY DETRAS
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles[0].route, (route) => false);
      }
    } else {
      MySnackbar.show(context, responseApi.message);
    }
  }
}
