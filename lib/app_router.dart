import 'package:flutter/material.dart';
import 'package:news_app/constants/app_constants.dart';
import 'package:news_app/presentation/screens/main_screen/main_screen.dart';

class AppRouter{

  Route? generateRoute (RouteSettings settings) {
    switch (settings.name) {
      case allNewsScreen:
        return MaterialPageRoute(builder: (_) => NewsScreen());
    }
    return null;
  }
}