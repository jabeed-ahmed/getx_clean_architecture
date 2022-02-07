import 'package:flutter_clean_architecture/src/data/models/article_model.dart';
import 'package:flutter_clean_architecture/src/domain/entities/news_article.dart';

class NewsArticleModel extends NewsArticle {
  const NewsArticleModel({
    String? status,
    int? totalResults,
    List<ArticleModel>? articles,
  }) : super(
          status: status,
          totalResults: totalResults,
          articles: articles,
        );

  factory NewsArticleModel.fromJson(Map<String, dynamic> map) {
    return NewsArticleModel(
      status: map['status'] as String,
      totalResults: map['totalResults'] as int,
      articles: List<ArticleModel>.from(
          map["articles"].map((x) => ArticleModel.fromJson(x))),
    );
  }
}
