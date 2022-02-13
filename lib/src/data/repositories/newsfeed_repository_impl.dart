import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/errors/failure.dart';
import 'package:flutter_clean_architecture/src/data/data_sources/remote/newsfeed_data_source.dart';
import 'package:flutter_clean_architecture/src/data/models/news_article_model.dart';
import 'package:flutter_clean_architecture/src/domain/repositories/newsfeed_repository.dart';

class NewsfeedRepositoryImpl implements NewsfeedRepository {
  final NewsfeedDataSource newsfeedDataSource;
  NewsfeedRepositoryImpl({required this.newsfeedDataSource});

  @override
  Future<Either<Failure, NewsArticleModel>> getNewsArticle() async {
    final response = await newsfeedDataSource.getArticles();

    return response.fold(
      (failure) => Left(failure),
      (articles) async {
        if (articles.totalResults != null) {
          return Right(articles);
        }
        return const Left(Failure('Can not find articles right now'));
      },
    );
  }
}
