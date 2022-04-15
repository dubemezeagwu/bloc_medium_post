import 'package:bloc_medium_post/data/api_service.dart';
import 'package:bloc_medium_post/data/model.dart';

class Repository {
  final newsApiProvider = NewsApiProvider();

  Future<List<NewsArticle>> fetchAllNews () => newsApiProvider.getArticles();
}