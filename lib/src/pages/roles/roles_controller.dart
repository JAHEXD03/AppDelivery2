// ignore_for_file: unnecessary_new

import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/material.dart';

class RolesController {
  BuildContext context;
  User user;
  Function refresh;
  SharePref sharePref = new SharePref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    //OBTENIENDO USUARIO DE SESION
    user = User.fromJson(await sharePref.read('user'));

    refresh();
  }

  void goToPage(String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
}
