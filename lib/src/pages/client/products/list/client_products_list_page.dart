// ignore_for_file: unnecessary_new, prefer_final_fields, prefer_const_constructors

import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/pages/client/products/list/client_products_list_cntroller.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key key}) : super(key: key);

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ClientProductsListController _con = new ClientProductsListController();
  //User u = new User();

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
    return DefaultTabController(
      length: _con.categories?.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            actions: [_shoppingBag()],
            flexibleSpace: Column(
              children: [
                SizedBox(height: 40),
                _menuDrawer(),
                SizedBox(height: 20),
                _textFieldSearch()
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(_con.categories.length, (index) {
                return Tab(
                  child: Text(_con.categories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),
        drawer: _drawer(),
        body: TabBarView(
          children: _con.categories.map((Category category) {
            return Text('Hola');
          }).toList(),
        ),
      ),
    );
  }

  Widget _shoppingBag() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 15, top: 13),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
          ),
        ),
        Positioned(
          right: 16,
          top: 15,
          child: Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        )
      ],
    );
  }

  Widget _textFieldSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar',
          suffixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
          ),
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey[500],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey[300],
            ),
          ),
          //si escribe el usuario no se perdera el diseño
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey[300],
            ),
          ),
          contentPadding: EdgeInsets.all(15),
        ),
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
          ListTile(
            onTap: _con.goToUpdatePage,
            title: Text('Editar perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
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
