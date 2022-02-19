import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/core/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture/src/core/widgets/error_widget.dart'
    as error_widget;
import 'package:flutter_clean_architecture/src/presentation/news/news_controller.dart';
import 'package:get/get.dart';

import 'widgets/news_view.dart';

class NewsScreen extends GetView<NewsController> {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.yellow,
        appBar: appBar(),
        body: Obx(
          () {
            switch (controller.viewState.value) {
              case ViewState.busy:
                return const LoadingWidget();
              case ViewState.error:
                return const error_widget.ErrorWidget();
              case ViewState.data:
                return const NewsView();
              default:
                return const LoadingWidget();
            }
          },
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 8.0,
      backgroundColor: Colors.yellow,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.adb,
            color: Colors.black,
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(
            'NewsReader',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ).paddingAll(4.0),
    );
  }
}
