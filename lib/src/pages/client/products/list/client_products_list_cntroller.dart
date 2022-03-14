import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/material.dart';

class ClientProductsListController {
  BuildContext context;
  SharePref _sharePref = new SharePref();

  Future init(BuildContext context) {
    this.context = context;
  }

  logout() {
    _sharePref.logout(context);
  }
}
