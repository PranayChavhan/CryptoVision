import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  final String postUrl;
  ArticleScreen({required this.postUrl});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  // final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "CryptoNews",
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.share))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.postUrl,
          // onWebViewCreated: (WebViewController webViewController){
          //   _controller.complete(webViewController);
          // },
        ),
      ),
    );
  }
}
