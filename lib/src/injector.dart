import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_clean_architecture/src/core/network/network_info.dart';
import 'package:flutter_clean_architecture/src/data/api/dio_client.dart';
import 'package:flutter_clean_architecture/src/data/repositories/newsfeed_repository_impl.dart';
import 'package:flutter_clean_architecture/src/domain/repositories/newsfeed_repository.dart';
import 'package:get_it/get_it.dart';

import 'data/data_sources/remote/newsfeed_data_source.dart';
import 'domain/use_cases/get_news_articles.dart';

GetIt injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // CONNECTIVITY
  injector.registerSingleton<Connectivity>(Connectivity());

  // NETWORK
  injector
      .registerSingleton<NetworkInfoI>(NetworkInfo(connectivity: injector()));

  // Dio client
  injector.registerSingleton<DioClient>(DioClient());

  // Dependencies
  injector.registerSingleton<NewsfeedDataSource>(
      NewsfeedDataSource(client: injector()));

  // *
  injector.registerSingleton<NewsfeedRepository>(
    NewsfeedRepositoryImpl(
        newsfeedDataSource: NewsfeedDataSource(client: injector())),
  );

  // UseCases
  injector.registerSingleton<GetNewsArticles>(GetNewsArticles(injector()));
}
