import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'Article.dart';
class News {

  List<Article> news  = [];

  String getDate(){
    var date = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<List<Article>> getNews() async{
    //todo: change this date to current date
    String url = "https://newsapi.org/v2/everything?q=crypto&from=${getDate()}1&sortBy=publishedAt&apiKey=a27b9344271d497489d7d4343fa0dea1";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            author: element['author'] ?? "author",
            title: element['title'] ?? "title",
            description: element['description'] ?? "description",
            url: element["url"] ?? "url",
            urlToImage: element['urlToImage'] ?? "toimage",
            publishedAt:element['publishedAt'] ?? "publishedDate",
            content: element["content"] ?? "content",
          );
          news.add(article);
        }

      });
    }

    return news;
  }


}





