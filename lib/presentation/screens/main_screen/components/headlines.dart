import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/news_cubit.dart';
import 'package:news_app/constants/app_constants.dart';
import 'package:news_app/data/models/news_details_arguments.dart';
import 'package:news_app/presentation/screens/news_details_screen/news_details_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data/models/news.dart';

class Headlines extends StatelessWidget {
  const Headlines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
      if (state is NewsInitState) {
        context.read<NewsCubit>().getAllNews('a');
      }
      if (state is NewsLoading) {
        return Shimmer.fromColors(
          enabled: true,
          baseColor: greyColor,
          highlightColor: whiteColor,
          child: Column(
            children: [ShimmeringContainer(), ShimmeringContainer()],
          ),
        );
      } else if (state is NewsLoaded) {
        List<News> news = state.news;
        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            DateTime now = DateTime.now();
            DateTime publishedAt = DateTime.parse(news[index].publishedAt);
            Duration diff = now.difference(publishedAt);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => NewsDetailsScreen(
                                arguments: NewsDetailsArguments(
                              news[index].source,
                              news[index].author,
                              news[index].title,
                              news[index].description,
                              news[index].url,
                              news[index].image,
                              news[index].publishedAt,
                              news[index].content,
                            ))));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: news[index].image,
                        placeholder: (context, url) =>
                            Image.asset(placeholderImage),
                        errorWidget: (context, url, error) =>
                            Image.asset(placeholderImage),
                        height: 200,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        news[index].title,
                        style: const TextStyle(
                            fontWeight: semiBoldFont, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        news[index].description,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            diff.inDays > 0
                                ? '${diff.inDays} Day(s) Ago'
                                : 'Today',
                            style: const TextStyle(
                                fontWeight: regularFont, fontSize: 11),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Source: ${news[index].source}',
                            style: const TextStyle(
                                fontWeight: semiBoldFont, fontSize: 11),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.share,
                              color: blackColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.bookmark_border_outlined,
                              color: blackColor,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return Container();
      }
    });
  }

  Widget ShimmeringContainer() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Container(
            height: 200,
            width: double.infinity,
            color: greyColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Container(
            height: 20,
            width: double.infinity,
            color: greyColor,
          ),
        )
      ],
    );
  }
}
