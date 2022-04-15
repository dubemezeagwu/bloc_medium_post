import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'model.dart';

class NewsApiProvider {

// News end-point for Tech-Crunch news
  final String endPointUrl = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$_apiKey";
  final client = Client();

  // This is a unique apiKey, when you register for this api it is generated specifically for you.
  static const _apiKey = "1c5cf07ee4be47c293247979dc4c15f4";

  Future <List<NewsArticle>> getArticles () async {
    final Response response = await client.get(Uri.parse(Uri.encodeFull(endPointUrl)));

    if (response.statusCode == 200){
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json["articles"];

      // Allows us get the different articles from the json file and put them into a list.
      List<NewsArticle> articles = body.map((dynamic item) => NewsArticle.fromJson(item)).toList();
      return articles;
    } else {
      throw "Cannot get the Articles";
    }

  }
}