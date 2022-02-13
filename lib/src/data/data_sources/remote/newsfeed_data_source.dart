import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/errors/failure.dart';
import 'package:flutter_clean_architecture/src/core/utils/constants.dart';
import 'package:flutter_clean_architecture/src/data/api/dio_client.dart';
import 'package:flutter_clean_architecture/src/data/api/result.dart';
import 'package:flutter_clean_architecture/src/data/models/news_article_model.dart';

class NewsfeedDataSource {
  final DioClient client;

  NewsfeedDataSource({required this.client});

  Future<Either<Failure, NewsArticleModel>> getArticles() async {
    final Result articles = await client
        .get('/top-headlines?language=en&pageSize=10&apiKey=$apiKey');
    if (articles is SuccessState) {
      var jsonData = NewsArticleModel.fromJson(articles.value);
      return Right(jsonData);
    } else {
      return const Left(Failure(errorMessage));
    }
  }
}
