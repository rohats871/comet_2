import 'dart:core';

import 'package:comet/helper/news.dart';
import 'package:comet/models/article_model.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({required this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(opacity: 0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.share,
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: _loading
                  ? Container(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            url: articles[index].url,
                            description: articles[index].description);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
