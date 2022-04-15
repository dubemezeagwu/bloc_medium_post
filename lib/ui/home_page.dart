import 'package:bloc_medium_post/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import '../data/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text("Get Tech News"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white70,
        onPressed: () {
          newsBloc.fetchAllNews();
        },
        child: const Icon(Icons.download_rounded),
      ),
      body: StreamBuilder(
        stream: newsBloc.allNews,
        builder: (context, AsyncSnapshot<List<NewsArticle>> snapshot){

          if (snapshot.hasData){
            List<NewsArticle>? articles = snapshot.data;
            return ListView.builder(
              itemCount: articles!.length,
              itemBuilder: (context, index) {
                return NewsList(context, articles[index]);
              },
            );
          } else if (snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          return const Center(child: Text(
            "CLICK THE DOWNLOAD BUTTON TO GET THE LATEST NEWS!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),));
        },
      ),
    );
  }
}

// Scrollable Widget that houses the list of news.
Widget NewsList (BuildContext context, NewsArticle article){
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0
            ),
          ]),
      child: Column(
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(article.urlToImage),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(12.0),),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade400,
                borderRadius: BorderRadius.circular(30.0)
            ),
            child: Text(
              article.source.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                  color: Colors.black54),),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            article.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16.0,),
          )
        ],
      ),
    ),
  );
}
