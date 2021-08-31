import 'package:cached_network_image/cached_network_image.dart';
import 'package:comet/Screens/article.dart';
import 'package:comet/helper/data.dart';
import 'package:comet/helper/news.dart';
import 'package:comet/models/article_model.dart';
import 'package:comet/models/category_modal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = new News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Comet",
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              Text(
                "News",
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    ///
                    /// Categories
                    ///
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTiles(
                              imageURL: categories[index].imageUrl,
                              categoryName: categories[index].categoryName,
                            );
                          },
                        ),
                      ),

                      ///
                      /// Blogs
                      ///
                      Container(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                  imageUrl: articles[index].urlToImage,
                                  title: articles[index].title,
                                  url: articles[index].url,
                                  description: articles[index].description);
                            }),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryTiles extends StatelessWidget {
  final imageURL;
  final categoryName;
  CategoryTiles({this.imageURL, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                width: 120,
                height: 60,
                fit: BoxFit.cover,
                imageUrl: imageURL,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black26,
              ),
              width: 120,
              height: 60,
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;
  BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.network(imageUrl),
            Text(title),
            Text(description),
          ],
        ),
      ),
    );
  }
}
