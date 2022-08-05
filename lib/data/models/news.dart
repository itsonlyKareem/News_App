class News {
  late String source;
  late String author;
  late String title;
  late String description;
  late String url;
  late String image;
  late String publishedAt;
  late String content;


   News.fromJson(Map<String, dynamic> json) {
     var sourceObject = json['source'];
     source = sourceObject['name'];
     author = json['author'];
     title = json['title'];
     description = json['description'];
     url = json['url'];
     image = json['urlToImage'];
     publishedAt = json['publishedAt'];
     content = json['content'];
  }


}
