import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/models/news_details_arguments.dart';
import 'package:news_app/presentation/screens/news_details_screen/news_details_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../business_logic/cubit/top_news_cubit.dart';
import '../../../../constants/app_constants.dart';
import '../../../../data/models/top_news.dart';

class NewsCarousel extends StatelessWidget {
  const NewsCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopNewsCubit, TopNewsState>(builder: (context, state) {
      if (state is TopNewsInitState) {
        context.read<TopNewsCubit>().getTopHeadlines('a');
      }
      if (state is TopNewsLoading) {
        return Shimmer.fromColors(
            enabled: true,
            highlightColor: whiteColor,
            baseColor: greyColor,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
            ]));
      } else if (state is TopNewsLoaded) {
        List<TopNews> topNews = state.topNews;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: 4,
              options: CarouselOptions(
                  initialPage: 0,
                  height: 350,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal),
              itemBuilder: (context, index, pageIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NewsDetailsScreen(
                                    arguments: NewsDetailsArguments(
                                  topNews[index].source,
                                  topNews[index].author,
                                  topNews[index].title,
                                  topNews[index].description,
                                  topNews[index].url,
                                  topNews[index].image,
                                  topNews[index].publishedAt,
                                  topNews[index].content,
                                ))));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Hero(
                        tag: topNews[index].title,
                        child: CachedNetworkImage(
                          imageUrl: topNews[index].image,
                          height: 250,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Image.asset(placeholderImage),
                          errorWidget: (context, url, error) =>
                              Image.asset(placeholderImage),
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Text(
                          topNews[index].title,
                          style: const TextStyle(
                            fontWeight: semiBoldFont,
                            fontFamily: fontFamily,
                            fontSize: 20,
                          ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            const Divider(
              height: 0,
              thickness: 1,
              indent: 15,
              endIndent: 15,
            )
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
