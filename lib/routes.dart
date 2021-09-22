// 路由列表

import 'package:flutter/material.dart';

final routes = {
  '/': (context) => LandingPage(),
  '/main': (context) => TabsWrapper(),
  '/login': (context) => LoginPage(),
  '/forgot': (context) => ForgotPage(),
  '/profile': (context) => ProfileEdit()
};

RouteFactory onGenerteRoute = (RouteSettings settings) {
  final String name = settings.name!;
  final Function pageContentBuilder = routes[name]!;
  if (settings.arguments != null) {
    final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments));
    return route;
  } else {
    final Route route =
        MaterialPageRoute(builder: (context) => pageContentBuilder(context));
    return route;
  }
};
