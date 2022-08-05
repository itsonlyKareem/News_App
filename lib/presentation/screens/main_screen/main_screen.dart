import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/business_logic/cubit/news_cubit.dart';
import 'package:news_app/constants/app_constants.dart';

import '../../../data/models/news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late List<News> allNews;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsCubit>(context).getAllNews('a');
  }

  // Checks if the state is loaded or not.
  Widget buildBlocWidget() {
    return BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
      if (state is NewsLoaded) {
        allNews = (state.news);
        print(allNews[0]);
        return buildLoadedWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  // Builds the loaded state.
  Widget buildLoadedWidget() {
    return Container();
  }

  //Shows the loading indicator.
  Widget showLoadingIndicator() {
    return Container();
  }

  //Build the App Bar.
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: appBarActions(),
    );
  }

  List<Widget> appBarActions() {
    return [
      GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 25,
            width: 25,
            child: SvgPicture.asset(menu),
          ),
        ),
      ),
      const Spacer(),
      GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 25,
            width: 25,
            child: SvgPicture.asset(search),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 25,
            width: 25,
            child: SvgPicture.asset(topHeadlines),
          ),
        ),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
      ),
    );
  }
}
