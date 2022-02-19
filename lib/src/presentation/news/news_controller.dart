import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/errors/failure.dart';
import 'package:flutter_clean_architecture/src/core/network/network_info.dart';
import 'package:flutter_clean_architecture/src/data/models/news_article_model.dart';
import 'package:flutter_clean_architecture/src/domain/use_cases/get_news_articles.dart';
import 'package:get/get.dart';
import 'package:flutter_clean_architecture/src/injector.dart';

enum ViewState { initial, busy, error, data }

class NewsController extends GetxController {
  final network = injector<NetworkInfoI>();

  final viewState = ViewState.initial.obs;
  final connectvityResult = ConnectivityResult.none.obs;
  NewsArticleModel? _articles;
  NewsArticleModel? get articles => (_articles);
  bool localArticlesView = false;
  final historyViewState = <ViewState>[];
  final getRemoteArticles = injector<GetNewsArticles>();
  late Either<Failure, NewsArticleModel> failureOrArticles;

  @override
  void onInit() async {
    super.onInit();

    connectvityResult.value = await network.connectivityResult;

    if (connectvityResult.value != ConnectivityResult.none) {
      remoteFetch();
    }

    // listen to connectivity changed event and update connectvityResult value
    network.onConnectivityChanged.listen((event) {
      connectvityResult.value = event;
      // automatically evoke remote fetch if device is offline
      // and articles data is empty, null or in local view
      if (event != ConnectivityResult.none &&
          (_articles?.articles == null ||
              _articles!.articles!.isEmpty ||
              localArticlesView)) {
        remoteFetch();
      }
    });
  }

  // feth data from articles service
  Future<void> remoteFetch() async {
    if (viewState.value == ViewState.busy) return;
    if (connectvityResult.value == ConnectivityResult.none) {
      Get.snackbar("Can't refresh when offline",
          "Please connect your device to wifi or mobile network",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    _setState(ViewState.busy);
    failureOrArticles = await getRemoteArticles.call();
    _handleFetchResult(failureOrArticles);
  }

  void _handleFetchResult(Either<Failure, NewsArticleModel> result,
      [bool local = false]) {
    result.fold((feilure) {
      _articles!.articles!.clear();
      _setState(ViewState.error);
      Get.snackbar('Refresh failed!', "Can't load articles",
          snackPosition: SnackPosition.BOTTOM);
    }, (data) {
      _articles = data;
      _setState(ViewState.data);
      final notifyLocal = local ? '(offline mode)' : '';
      Get.snackbar('Refresh successfuly!',
          ' ${_articles!.articles!.length} new articles ready for reading $notifyLocal',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  // set viewstate
  void _setState(ViewState state) {
    viewState.value = state;
    historyViewState.add(state);
  }

  @override
  void onClose() {
    viewState.close();
    connectvityResult.close();
  }
}
