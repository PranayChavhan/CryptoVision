import 'package:flutter/material.dart';
import '../screens/article_screen.dart';

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  const NewsTile(
      {required this.imgUrl,
      required this.desc,
      required this.title,
      required this.content,
      required this.posturl,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleScreen(
                      postUrl: posturl,
                    )));
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        imgUrl,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc,
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.grey.shade200, fontSize: 14),
                  )
                ],
              ),
            ),
          )),
    );
  }
}