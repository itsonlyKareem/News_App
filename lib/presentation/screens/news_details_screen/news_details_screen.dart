import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_details_arguments.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_constants.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsDetailsArguments arguments;

  const NewsDetailsScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime publishedAt = DateTime.parse(arguments.publishedAt);
    Duration diff = now.difference(publishedAt);
    print(arguments.content);

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: arguments.image,
                placeholder: (context, url) => Image.asset(placeholderImage),
                errorWidget: (context, url, error) =>
                    Image.asset(placeholderImage),
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: blackColor.withOpacity(0.5)),
                        child: const Icon(
                          Icons.chevron_left,
                          size: 32,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: blackColor.withOpacity(0.5)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.share,
                          size: 18,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: blackColor.withOpacity(0.5)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.bookmark_border_outlined,
                          size: 18,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.30,
                    right: 8.0,
                    left: 8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: blackColor.withOpacity(0.5)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          diff.inDays > 0
                              ? '${diff.inDays} Day(s) Ago'
                              : 'Today',
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 12,
                              fontWeight: mediumFont),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: blackColor.withOpacity(0.5)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Source: ${arguments.source}',
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 12,
                              fontWeight: mediumFont),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: whiteColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 30, bottom: 10),
                        child: Container(
                          color: whiteColor,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  arguments.title,
                                  style: const TextStyle(
                                    color: blackColor,
                                    fontFamily: fontFamily,
                                    fontWeight: semiBoldFont,
                                    fontSize: 18,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(thickness: 1, endIndent: 20, indent: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 10),
                        child: Text(
                          arguments.description,
                          style: const TextStyle(
                            color: blackColor,
                            fontWeight: regularFont,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 10),
                        child: Text(
                          arguments.content.replaceAll(
                              arguments.content.substring(
                                  arguments.content.indexOf('['),
                                  arguments.content.indexOf(']') + 1),
                              ''),
                          style: const TextStyle(
                            color: blackColor,
                            fontWeight: regularFont,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Want to read more? visit ',
                                style: TextStyle(
                                  color: blackColor,
                                  fontFamily: fontFamily,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: arguments.url,
                                style: const TextStyle(
                                  color: blackColor,
                                  fontFamily: fontFamily,
                                  fontSize: 12,
                                  fontWeight: semiBoldFont,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () async {
                                  if (await canLaunchUrl(Uri.parse(arguments.url)) == true) {
                                    launchUrl(Uri.parse(arguments.url));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Can\'t launch URL')));
                                  }
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
