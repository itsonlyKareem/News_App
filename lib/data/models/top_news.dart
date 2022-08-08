class TopNews {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String image;
  final String publishedAt;
  final String content;

  TopNews(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.image,
      required this.publishedAt,
      required this.content});

  factory TopNews.fromJson(Map<String, dynamic> json) {
    var sourceObject = json['source'];
    return TopNews(
      source: sourceObject['name'] ?? '',
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      image: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ??'',
      content: json['content'] ?? ''
    );
  }
}
