import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/news.dart';
import '../../data/models/top_news.dart';
import '../../data/repositories/news_repository.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitState());

  Future<void> getAllNews(String query) async {
    emit(NewsLoading());
    List<News> news = await NewsRepository().getAllNews(query);
    emit(NewsLoaded(news));
  }
}
