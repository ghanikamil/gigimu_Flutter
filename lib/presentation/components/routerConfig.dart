import 'package:flutter/material.dart';
import 'package:gigimu/presentation/screens/bottomNavbar.dart';
import 'package:gigimu/presentation/screens/loginPage.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../screens/registerPage.dart';

class RouterNavigation {
  RouterConfig<Object> getRoute(){
    var box = Hive.box("userData");
    final bool hasToken = box.get('token') != null;
    String initialLocation = hasToken ? "/" : "/login";

    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: "/",
          name: "index",
          builder: (context,state)=> BottomNavbar()
        ),
        GoRoute(
            path: "/login",
            name: "login",
            builder: (context,state)=> LoginPage()
        ),
        GoRoute(
            path: "/register",
            name: "register",
            builder: (context,state)=> RegisterPage()
        ),
      ]
    );
  }
}