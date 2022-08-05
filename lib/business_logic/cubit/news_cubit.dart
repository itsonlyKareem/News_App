import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/news.dart';
import '../../data/repositories/news_repository.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;
  List<News> news = [];
  NewsCubit(this.newsRepository) : super(NewsInitial());

  List<News> getAllNews(String query) {
    newsRepository.getAllNews(query).then((value) {
      emit(NewsLoaded(value));
      news = value;
    });

    return news;
  }
}
