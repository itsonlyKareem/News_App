import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/constants/app_constants.dart';
import 'package:news_app/data/models/news.dart';

class NewsWebServices {
  late Dio dio;

/*
  In this constructor, the base options for Dio are initialized.
   */
  NewsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: BASE_URL,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      headers: {'Authorization': API_KEY}
    );

    dio = Dio(options);
  }

  Future<dynamic> getAllNews(String query) async {
    try {
      Response response = await dio.get(EVERYTHING_ENDPOINT,
      queryParameters: {'q': query});
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
