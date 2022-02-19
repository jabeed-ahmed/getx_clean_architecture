import 'package:flutter/material.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: const SizedBox(
            height: 100,
            child: Text("Jabeed"),
          ),
        );
      },
    );
  }
}
