import 'dart:collection';

import 'package:news_app/data/models/news.dart';

import '../web_services/web_services.dart';

class NewsRepository {
  final NewsWebServices newsWebServices;

  NewsRepository(this.newsWebServices);

  Future<List<News>> getAllNews(String query) async {
    List<News> allNews = [];
    final news = await newsWebServices.getAllNews(query);
    var response = news['articles'] as List;
    for (var element in response) {
      allNews.add(News.fromJson(element));
    }
    return [];
  }
}
