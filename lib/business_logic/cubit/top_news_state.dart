part of 'top_news_cubit.dart';

@immutable
abstract class TopNewsState {}

class TopNewsInitState extends TopNewsState {}

class TopNewsLoading extends TopNewsState {}

class TopNewsLoaded extends TopNewsState {
  final List<TopNews> topNews;
  TopNewsLoaded(this.topNews);
}
