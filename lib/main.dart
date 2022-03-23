// ignore_for_file: prefer_const_constructors

import 'package:app_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:app_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:flutter/material.dart';

import 'src/pages/client/products/list/client_products_list_page.dart';
import 'src/pages/login/login_page.dart';
import 'src/pages/register/register_page.dart';
import 'src/pages/roles/roles_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Delivery App",
      debugShowCheckedModeBanner: false,
      initialRoute: "login",
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'roles': (BuildContext context) => RolesPage(),
        'client/products/list': (BuildContext context) =>
            ClientProductsListPage(),
        'delivevry/orders/list': (BuildContext context) =>
            DeliveryOrdersListPage(),
        'restaurant/orders/list': (BuildContext context) =>
            RestaurantOrdersListPage()
      },
    );
  }
}
