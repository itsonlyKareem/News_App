
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/news_cubit.dart';
import 'package:news_app/constants/app_constants.dart';
import 'package:news_app/data/repositories/news_repository.dart';
import 'package:news_app/data/web_services/web_services.dart';
import 'package:news_app/presentation/screens/main_screen/main_screen.dart';
import 'package:news_app/presentation/screens/news_details_screen/news_details_screen.dart';

class AppRouter{

  Route? generateRoute (RouteSettings settings) {
    switch (settings.name) {
      case allNewsScreen:
        return MaterialPageRoute(builder: (_) => const NewsScreen());
    }
  }
}