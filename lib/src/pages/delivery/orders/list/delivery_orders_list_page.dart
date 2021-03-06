// ignore_for_file: prefer_const_constructors

import 'package:app_delivery/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({Key key}) : super(key: key);

  @override
  State<DeliveryOrdersListPage> createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {
  DeliveryOrdersListController _con = new DeliveryOrdersListController();

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
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
        backgroundColor: MyColors.primaryColor,
      ),
      drawer: _drawer(),
      body: Center(
          /*child: ElevatedButton(
          onPressed: _con.logout,
          child: Text('Cerrar sesion'),
        ),*/
          ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/img/menu.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      //ListView es igual que un Colum solo que nos deja hacer scroll
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: MyColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_con.user?.name ?? ''}${_con.user?.lastname ?? ''}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                Text(
                  '${_con.user?.email ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                ),
                Text(
                  '${_con.user?.phone ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                ),
                Container(
                  child: _fadeInImage(),
                )
              ],
            ),
          ),
          _con.user != null
              ? _con.user.roles.length > 1
                  ? ListTile(
                      onTap: _con.goToRoles,
                      title: Text('Selecciobnr rol'),
                      trailing: Icon(Icons.person_outline),
                    )
                  : Container()
              : Container(),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar session'),
            trailing: Icon(Icons.power_settings_new),
          )
        ],
      ),
    );
  }

  Widget _fadeInImage() {
    if (_con.user?.image != null) {
      return Container(
        height: 60,
        margin: EdgeInsets.only(top: 10),
        child: FadeInImage(
          image: NetworkImage(_con.user.image),
          fit: BoxFit.contain,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      );
    } else {
      return Container(
        height: 60,
        margin: EdgeInsets.only(top: 10),
        child: FadeInImage(
          image: AssetImage('assets/img/no-image.png'),
          fit: BoxFit.contain,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),
        ),
      );
    }
  }

  void refresh() {
    setState(() {});
  }
}
