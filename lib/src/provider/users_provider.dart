// AQUI SE HARA LAS CONSULTAS http

// ignore_for_file: avoid_print, missing_return, prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:app_delivery/src/api/environment.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/utils/share_pref.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;

class UsersProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/users';

  BuildContext context;
  String token;
  User sessionUser;

  Future init(BuildContext context, {User sessionUser}) {
    this.context = context;
    //this.token = token;
    this.sessionUser = sessionUser;
  }

  Future<Stream> createWhitImae(User user, File image) async {
    try {
      Uri url = Uri.http(_url, '$_api/register');
      final request = http.MultipartRequest('POST', url);

      if (image != null) {
        request.files.add(
          http.MultipartFile('image', http.ByteStream(image.openRead().cast()),
              await image.length(),
              filename: basename(image.path)),
        );
      }

      request.fields['user'] = json.encode(user);
      final response = await request.send(); //SE ENVIA LA PETICION
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error,$e');
    }
  }

  Future<User> getById(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api/findById/$id');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        new SharePref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
      //
    } catch (e) {
      print('Error,$e');
      return null;
    }
  }

  Future<Stream> update(User user, File image) async {
    try {
      Uri url = Uri.http(_url, '$_api/update');
      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = sessionUser.sessionToken;

      if (image != null) {
        request.files.add(
          http.MultipartFile('image', http.ByteStream(image.openRead().cast()),
              await image.length(),
              filename: basename(image.path)),
        );
      }

      request.fields['user'] = json.encode(user);
      final response = await request.send(); //SE ENVIA LA PETICION

      if (response.statusCode == 401) {
        new SharePref().logout(context, sessionUser.id);
      }

      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error,$e');
    }
  }

  Future<ResponseApi> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/register');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> logout(String idUser) async {
    try {
      Uri url = Uri.http(_url, '$_api/logout');
      String bodyParams = json.encode({'id': idUser});
      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({'email': email, 'password': password});
      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
