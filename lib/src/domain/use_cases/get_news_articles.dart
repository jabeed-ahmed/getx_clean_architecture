import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/errors/failure.dart';
import 'package:flutter_clean_architecture/src/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture/src/data/models/news_article_model.dart';
import 'package:flutter_clean_architecture/src/domain/repositories/newsfeed_repository.dart';

class GetNewsArticles implements UseCase<NewsArticleModel> {
  final NewsfeedRepository repository;
  GetNewsArticles(this.repository);

  @override
  Future<Either<Failure, NewsArticleModel>> call() async {
    return repository.getNewsArticle();
  }
}
