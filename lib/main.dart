import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/news_cubit.dart';
import 'package:news_app/business_logic/cubit/top_news_cubit.dart';
import 'package:news_app/constants/app_constants.dart';
import 'package:news_app/presentation/screens/main_screen/main_screen.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(create: (context) => NewsCubit()),
        BlocProvider<TopNewsCubit>(create: (context) => TopNewsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: fontFamily,
        ),
        home: const NewsScreen(),
        initialRoute: allNewsScreen,
      ),
    );
  }
}
