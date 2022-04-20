import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantOrdersListController {
  BuildContext context;
  SharePref _sharePref = new SharePref();
  Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  User user;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    //Ya se tienen los datos del usuario
    this.user = User.fromJson(await _sharePref.read('user'));

    refresh();
  }

  void logout() {
    _sharePref.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToCategorieCreate() {
    Navigator.pushNamed(context, 'restaurant/categories/create');
  }

  void goToProductsCreate() {
    Navigator.pushNamed(context, 'restaurant/products/create');
  }
}
