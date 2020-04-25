class News {
  String auther;
  String title;
  String description;
  String url;
  String publishedAt;
  String sourcename;
  String launchurl;

  News({this.auther, this.title, this.description, this.url, this.publishedAt,this.sourcename,this.launchurl});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        auther: json['author'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['urlToImage'] as String,
        publishedAt: json['publishedAt'] as String,
        sourcename:json['source']['name']as String,
        launchurl:json['url'] as String
         );
       
  }
}