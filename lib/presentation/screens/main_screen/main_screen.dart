import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/constants/app_constants.dart';
import 'package:news_app/presentation/screens/main_screen/components/headlines.dart';
import 'package:news_app/presentation/screens/main_screen/components/news_carousel.dart';
import 'package:news_app/presentation/screens/main_screen/components/see_more.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({Key? key}) : super(key: key);

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

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
        onTap: () {
          final state = _sideMenuKey.currentState;
          if (state!.isOpened) {
            state.closeSideMenu();
          } else {
            state.openSideMenu();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 25,
            width: 25,
            child: SvgPicture.asset(menu),
          ),
        ),
      ),
      const SizedBox(width: 20),
      const Center(
          child: Text(
        appTitle,
        style: TextStyle(
          fontSize: 16,
          color: blackColor,
          fontWeight: mediumFont,
        ),
      )),
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

  // Checks if the state is loaded or not.
  Widget buildBlocWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
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
          const SizedBox(height: 10),
          const NewsCarousel(),
          const SizedBox(height: 20),
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
                    headlinesText,
                    style: TextStyle(
                        color: blackColor,
                        fontFamily: fontFamily,
                        fontWeight: semiBoldFont),
                  ),
                  const Spacer(),
                  const SeeMore(),
                ],
              ),
            ),
          ),
          const Headlines()
        ],
      ),
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

  Widget buildMenu(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SideMenuItem(
          title: 'Saved',
          icon: Icons.bookmark,
          onClick: () {
          },
        ),
        Divider(
          thickness: 1,
          color: whiteColor,
          endIndent: MediaQuery.of(context).size.width * 0.25,
        ),
        const Text(
          'Categories',
          style: TextStyle(color: secondaryColor, fontWeight: semiBoldFont),
          textAlign: TextAlign.start,
        ),
        SideMenuItem(
            icon: Icons.cases_sharp, title: 'Business', onClick: () {}),
        SideMenuItem(
            icon: Icons.emoji_emotions, title: 'Entertainment', onClick: () {}),
        SideMenuItem(icon: Icons.newspaper, title: 'General', onClick: () {}),
        SideMenuItem(
            icon: Icons.local_hospital, title: 'Health', onClick: () {}),
        SideMenuItem(icon: Icons.science, title: 'Science', onClick: () {}),
        SideMenuItem(icon: Icons.sports, title: 'Sports', onClick: () {}),
        SideMenuItem(
            icon: Icons.electric_bolt, title: 'Technology', onClick: () {})
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SideMenu(
        key: _sideMenuKey,
        menu: buildMenu(context),
        type: SideMenuType.shrikNRotate,
        background: blackColor,
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
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class SideMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onClick;

  const SideMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        children: [
          Icon(
            icon,
            color: whiteColor,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
