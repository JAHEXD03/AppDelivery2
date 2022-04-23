import 'dart:convert';

import 'package:app_delivery/src/api/environment.dart';
import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/utils/my_snackbar.dart';
import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class CategoriesProvider {
  //
  String _url = Environment.API_DELIVERY;
  String _api = '/api/categories';

  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<ResponseApi> create(Category category) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(category);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };

      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        MySnackbar.show(context, 'Session expirada');
        new SharePref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<Category>> getAll() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };

      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        MySnackbar.show(context, 'Session expirada');
        new SharePref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body);
      Category category = Category.FromJsonList(data);
      return category.toList;
    } catch (e) {
      print('Error:$e');
      return [];
    }
  }
}
