// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

class LoginController {
  // late o el simbolo ?, le diceN a dart que nuetras variables no son null y eso respeta a la regla de dart de NULL SAFETY
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Future init(BuildContext context) {
    this.context = context;
  }

  //Metodo para ir a la pagna de registro
  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() {
    //Trim nos elimina espacios en blanco en los textos capturaos
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print("EMAIL $email");
    print("PASSWORD $password");
  }
}
