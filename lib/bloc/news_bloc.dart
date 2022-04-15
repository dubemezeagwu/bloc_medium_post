import 'dart:async';
import 'package:bloc_medium_post/data/model.dart';
import 'package:bloc_medium_post/data/repository.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsFetcher = StreamController<List<NewsArticle>>();

  // Getter for the Stream-controller stream.
  Stream <List<NewsArticle>> get allNews => _newsFetcher.stream;

  // Fetches all the news and add its add it's to the StreamController's sink
  fetchAllNews () async {
    List<NewsArticle> newsList = await _repository.fetchAllNews();
    _newsFetcher.sink.add(newsList);
  }

  // Dispose stream-controller
  dispose (){
    _newsFetcher.close();
  }
}

// Bloc instance
final newsBloc = NewsBloc();