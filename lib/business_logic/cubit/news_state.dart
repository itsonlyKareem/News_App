part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitState extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> news;
  NewsLoaded(this.news);
}