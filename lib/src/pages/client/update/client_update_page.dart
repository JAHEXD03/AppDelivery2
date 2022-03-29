// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_final_fields, avoid_unnecessary_containers

import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'client_update_controller.dart';

// Escribir stfull y el editor nos creara toda la estrutura de la clase

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({Key key}) : super(key: key);

  @override
  State<ClientUpdatePage> createState() => _ClientUpdatePage();
}

class _ClientUpdatePage extends State<ClientUpdatePage> {
  ClientUpdateController _con = new ClientUpdateController();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EDITAR PERFIL'),
          backgroundColor: MyColors.primaryColor,
        ),
        body: Container(
          child: SingleChildScrollView(
            // este Widget adapta nuestra pantalla a distintos tamaños de pantalla
            child: Column(
              children: [
                SizedBox(height: 50),
                _imageUser(),
                _textFieldName(),
                _textFieldLastName(),
                _textFieldPhone(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buttonUpdate());
  }

  Widget _iconBack() {
    return IconButton(
      onPressed: _con.backToLoginPage,
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    );
  }

  Widget _imageUser() {
    if (_con.imageFile != null) {
      return GestureDetector(
        onTap: _con.showAlertDialog,
        child: CircleAvatar(
          backgroundImage: FileImage(_con.imageFile),
          radius: 60,
          backgroundColor: Colors.grey[200],
        ),
      );
    } else {
      if (_con.user?.image != null) {
        return GestureDetector(
          onTap: _con.showAlertDialog,
          child: CircleAvatar(
            backgroundImage: NetworkImage(_con.user?.image),
            radius: 60,
            backgroundColor: Colors.grey[200],
          ),
        );
      } else {
        return GestureDetector(
          onTap: _con.showAlertDialog,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/img/user_profile_2.png'),
            radius: 60,
            backgroundColor: Colors.grey[200],
          ),
        );
      }
    }
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
          hintText: "Nombre",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.person,
            color: MyColors.primaryColor,
          ),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.lastNameController,
        decoration: InputDecoration(
          hintText: "Apellido",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.person_outline,
            color: MyColors.primaryColor,
          ),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: "Telefono",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.phone,
            color: MyColors.primaryColor,
          ),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
        ),
      ),
    );
  }

  Widget _buttonUpdate() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.update,
        child: Text(
          "ACTUALIZAR PERFIL",
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

  void refresh() {
    setState(() {});
  }
}
