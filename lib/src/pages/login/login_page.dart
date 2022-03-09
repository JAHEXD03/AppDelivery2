// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, sized_box_for_whitespace, unnecessary_new, unused_field, prefer_final_fields

import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/*CICLO DE VIDA 
  Primero se ejecuta el metodo initState, el cual va a ejecutar el metodo init en la clase LoginController, despues se ejecutara el metodo build el cual va a dibujar la intefas creada y por ultimo el metodo SchedulerBinding el cual inicializar los constructores*/

class _LoginPageState extends State<LoginPage> {
  //Se crea nustro objeto de tipo  LoginController
  LoginController _con = new LoginController();

  //Este metodo ejecuta el metodo init que inicaliza la clase LoginController
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin(),
            ),
            Positioned(
              top: 65,
              left: 27,
              child: _textLogin(),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: double.infinity,
              child: SingleChildScrollView(
                // El column nos permite posicionar un elemento sobre otro
                child: Column(
                  children: [
                    _lottieAnimation(),
                    _textFieldEmail(),
                    _textFieldPassword(),
                    _buttonLogin(),
                    _textDontHaveAccount(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Si los metodos tienen un _ eso quiere decir que son privados, de no estar asi son publicos

  Widget _textLogin() {
    return Text(
      "LOGIN",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: "NimbusSans",
        fontSize: 20,
      ),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,
      ),
    );
  }

  Widget _lottieAnimation() {
    return Container(
      margin: EdgeInsets.only(
        top: 100,
//Permitre adaptar el tamaño de la imagen a distintos tamaño de pantalla
        bottom: MediaQuery.of(context).size.height * 0.14,
      ),
      child: Lottie.asset(
        'assets/json/delivery.json',
        width: 350,
        height: 200,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Correo Elctronico",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.primaryColor,
          ),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.passwordController,
        //Hace que la contraseña no se muestre
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Contraseña",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.lock,
            color: MyColors.primaryColor,
          ),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.login,
        child: Text(
          "Ingresar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _textDontHaveAccount() {
// Row o Fila, nos permite poner un Widget a lado de otro
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿No tienes cuenta?",
          style: TextStyle(
            color: MyColors.primaryColor,
          ),
        ),
        SizedBox(width: 7),
        //Widget que permite agregar metodos, en este caso el metodo onTap nos permite navega entre pantallas
        GestureDetector(
          onTap: () {
            _con.goToRegisterPage();
          },
          child: Text(
            "REGISTRATE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
