import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/config/routes/app_routes.dart';
import 'package:flutter_clean_architecture/src/injector.dart';
import 'package:get/get.dart';

import 'src/config/routes/get_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.topLevel,
      title: "Article",
      initialRoute: AppRoutes.newsScreen,
      getPages: Routes.getAllPages(),
      
    );
  }
}
