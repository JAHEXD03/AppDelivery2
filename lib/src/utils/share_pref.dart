/*
*ALMACENAMINTO CON PERSISTENCIA DE DATOS
*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
//METODO PARA ALMACENAR IMFORMACION EN EL STORAGE
  void save(String key, value) async {
    //PERMIRIRA USARE LOS METODOS DE SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

//METODO PARA LEEER LA INFO ALMACENADA

  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key) == null) {
      return null;
    } else {
      return json.decode(prefs.getString(key));
    }
  }

//PARA SABER SI HAY ALGUN DATO GUARDADO EN EL SharedPreferences

  Future<bool> contains(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey(key);
  }

//METODO PARA ELIMINAR UN DATO DE SharedPreferences

  Future<bool> remove(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }

  void logout(BuildContext context) async {
    await remove('user');
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }
}
