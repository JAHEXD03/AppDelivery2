import 'package:app_delivery/src/models/rol.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key key}) : super(key: key);

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text('Selecciona un rol'),
      ),
      body: Center(),
    );
  }

  Widget _cardRol(Rol rol) {
    return Column(
      children: [
        Container(
          height: 100,
          child: FadeInImage(
            image: rol.image != null ? NetworkImage(rol.image) : AssetImage(''),
          ),
        ),
      ],
    );
  }
}
