import 'package:flutter_clean_architecture/src/core/utils/constants.dart';
import 'package:flutter_clean_architecture/src/data/api/dio_client.dart';
import 'package:flutter_clean_architecture/src/data/api/result.dart';

class NewsfeedDataSource {
  final DioClient client;

  NewsfeedDataSource({required this.client});

  Future<Result> getArticles() async {
    final articles = await client
        .get('/top-headlines?language=en&pageSize=10&apiKey=$apiKey');
    return articles;
  }
}
