import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/errors/failure.dart';
import 'package:flutter_clean_architecture/src/data/models/news_article_model.dart';

abstract class NewsfeedRepository {
  Future<Either<Failure, NewsArticleModel>> getNewsArticle();
}
