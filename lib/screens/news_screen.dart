import 'package:cryptovision/components/my_drawer.dart';
import 'package:cryptovision/components/myappbar.dart';
import 'package:cryptovision/components/news_tile.dart';
import 'package:cryptovision/models/Article.dart';
import 'package:flutter/material.dart';
import '../models/News.dart';

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
        appBar: const MyAppBar(title: "CryptoNews"),
        drawer: MyDrawer(),
        body: Container(
          color: Colors.grey.shade900,
          child: FutureBuilder(
              future: news.getNews(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Article> data = snapshot.data!;
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imgUrl: data[index].urlToImage,
                          title: data[index].title,
                          desc: data[index].description,
                          content: data[index].content,
                          posturl: data[index].url,
                        );
                      });
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
