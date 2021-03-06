// ignore_for_file: prefer_const_constructors, unnecessary_new, missing_return

import 'dart:ffi';

import 'package:flutter/material.dart';

class MySnackbar {
  static Void show(BuildContext context, String text) {
    if (context == null) return null;

    FocusScope.of(context).requestFocus(new FocusNode());

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
