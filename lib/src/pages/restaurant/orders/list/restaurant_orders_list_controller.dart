import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantOrdersListController {
  BuildContext context;
  SharePref _sharePref = new SharePref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Future init(BuildContext context) {
    this.context = context;
  }

  void logout() {
    _sharePref.logout(context);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }
}
