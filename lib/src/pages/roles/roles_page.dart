import 'package:app_delivery/src/models/rol.dart';
import 'package:app_delivery/src/pages/roles/roles_controller.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key key}) : super(key: key);

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController _con = new RolesController();

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
        backgroundColor: MyColors.primaryColor,
        title: Text('Selecciona un rol'),
      ),
      body: ListView(
          children: _con.user != null
              ? _con.user.roles.map((Rol rol) {
                  return _cardRol(rol);
                }).toList()
              : []),
    );
  }

  Widget _cardRol(Rol rol) {
    return Column(
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.only(bottom: 15),
          margin: EdgeInsets.only(top: 50),
          child: FadeInImage(
            image: rol.image != null
                ? NetworkImage(rol.image)
                : AssetImage('assets/img/no-image.png'),
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage('assets/img/no-image.png'),
          ),
        ),
        Text(
          rol.name ?? '',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
