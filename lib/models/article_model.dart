class ArticleModel {
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String author;

  ArticleModel(
      {required this.description,
      required this.content,
      required this.title,
      required this.url,
      required this.urlToImage,
      required this.author});
}
