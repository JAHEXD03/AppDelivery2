// ignore_for_file: unnecessary_new, prefer_final_fields, missing_return

import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/provider/categories_provider.dart';
import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/material.dart';

class ClientProductsListController {
  BuildContext context;
  SharePref _sharePref = new SharePref();
  Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  User user;

  List<Category> categories = [];

  CategoriesProvider _categoriesProvider = new CategoriesProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    //Ya se tienen los datos del usuario
    this.user = User.fromJson(await _sharePref.read('user'));

    _categoriesProvider.init(context, user);

    getCategories();

    refresh();
  }

  void logout() {
    _sharePref.logout(context, user.id);
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }
}
