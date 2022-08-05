import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/business_logic/cubit/news_cubit.dart';
import 'package:news_app/constants/app_constants.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late List<News> allNews;
  bool connected = false;

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
        return buildLoadedWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  // Builds the loaded state.
  Widget buildLoadedWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          color: whiteColor,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: primaryColor,
                  ),
                ),
              ),
              const Text(
                topHeadlinesText,
                style: TextStyle(
                    color: blackColor,
                    fontFamily: fontFamily,
                    fontWeight: semiBoldFont),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Shows the loading indicator.
  Widget showLoadingIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          enabled: true,
          highlightColor: whiteColor,
          baseColor: greyColor,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  color: whiteColor,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: primaryColor,
                          ),
                        ),
                      ),
                      const Text(
                        topHeadlinesText,
                        style: TextStyle(
                            color: blackColor,
                            fontFamily: fontFamily,
                            fontWeight: semiBoldFont),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 200, width: double.infinity, color: greyColor),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 20, width: double.infinity, color: greyColor),
              ),
              const Divider(
                  height: 20,
                  thickness: 1,
                  color: greyColor,
                  indent: 20,
                  endIndent: 20),
              const SizedBox(height: 10),
              Container(
                color: whiteColor,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        width: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: primaryColor,
                        ),
                      ),
                    ),
                    const Text(
                      headlinesText,
                      style: TextStyle(
                          color: blackColor,
                          fontFamily: fontFamily,
                          fontWeight: semiBoldFont),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greyColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greyColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greyColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greyColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // If there is no Internet connection, this is triggered.
  Widget noInternetWidget() {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              noInternet,
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              noConnectionText,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: fontFamily,
                fontWeight: regularFont,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  //Build the App Bar.
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: whiteColor,
      elevation: 5,
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
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return buildBlocWidget();
            } else {
              return noInternetWidget();
            }
          },
          child: showLoadingIndicator(),
        ),
      ),
    );
  }
}
