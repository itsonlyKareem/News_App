import 'dart:collection';

import 'package:news_app/data/models/news.dart';
import 'package:news_app/data/models/top_news.dart';

import '../web_services/web_services.dart';

class NewsRepository {



  Future<List<News>> getAllNews(String query) async {
    List<News> allNews = [];
    final news = await NewsWebServices().getAllNews(query);
    var response = news['articles'] as List;
    for (var element in response) {
      allNews.add(News.fromJson(element));
    }
    return allNews;
  }

  Future<List<TopNews>> getTopHeadlines (String query) async {
    List<TopNews> allTopNews = [];
    final topNews = await NewsWebServices().getTopHeadlines(query);
    var response = topNews['articles'] as List;
    for (var element in response) {
      allTopNews.add(TopNews.fromJson(element));
    }
    return allTopNews;
  }
}
