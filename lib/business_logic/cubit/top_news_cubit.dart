import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/top_news.dart';
import '../../data/repositories/news_repository.dart';

part 'top_news_state.dart';

class TopNewsCubit extends Cubit<TopNewsState> {
  TopNewsCubit() : super(TopNewsInitState());

  Future<void>getTopHeadlines (String query) async {
    emit(TopNewsLoading());
    List<TopNews> topNews = await NewsRepository().getTopHeadlines(query);
    emit(TopNewsLoaded(topNews));
  }
}
