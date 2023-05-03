
import 'package:cryptovision/models/Article.dart';
import 'package:flutter/material.dart';
import '../components/myappbar.dart';
import '../models/News.dart';
import 'Widgets.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  late News news = news = News();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "News Data",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: FutureBuilder(
            future: news.getNews(),
            builder: (context, snapshot){
              if(snapshot.hasData){

                  List<Article> data = snapshot.data!;
                 return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    print("data hai bhai");
                    return NewsTile(
                      imgUrl: data[index].urlToImage,
                      title: data[index].title,
                      desc: data[index].description,
                      content: data[index].content,
                      posturl: data[index].url,
                    );

                    return const Text("hello");
                  });
              }
              if(snapshot.hasError){
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        )
    );
  }


}

