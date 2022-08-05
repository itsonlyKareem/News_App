
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/news_cubit.dart';
import 'package:news_app/constants/app_constants.dart';
import 'package:news_app/data/repositories/news_repository.dart';
import 'package:news_app/data/web_services/web_services.dart';
import 'package:news_app/presentation/screens/main_screen/main_screen.dart';

class AppRouter{
  late NewsRepository newsRepository;
  late NewsCubit newsCubit;

  AppRouter() {
    newsRepository = NewsRepository(NewsWebServices());
    newsCubit = NewsCubit(newsRepository);
  }

  Route? generateRoute (RouteSettings settings) {
    switch (settings.name) {
      case allNewsScreen:
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (BuildContext context) => NewsCubit(newsRepository),
          child: NewsScreen(),
        ));
    }
  }
}