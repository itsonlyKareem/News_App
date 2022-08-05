part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> news;
  NewsLoaded(this.news);
}
