import 'package:flutter_clean_architecture/src/config/routes/app_routes.dart';
import 'package:flutter_clean_architecture/src/presentation/news/news_binding.dart';
import 'package:flutter_clean_architecture/src/presentation/news/news_screen.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> getAllPages() {
    return [
      GetPage(
        name: AppRoutes.newsScreen,
        binding: NewsBinding(),
        page: () => const NewsScreen(),
      ),
    ];
  }
}
