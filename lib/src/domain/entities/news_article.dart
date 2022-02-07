import 'package:equatable/equatable.dart';

import 'articles.dart';

class NewsArticle extends Equatable {
  final String? status;
  final int? totalResults;
  final List<Articles?>? articles;

  const NewsArticle({
    this.status,
    this.totalResults,
    this.articles,
  });

  @override
  List<Object> get props {
    return [
      status!,
      totalResults!,
      articles!,
    ];
  }

  @override
  bool get stringify => true;
}
