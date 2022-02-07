import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/src/domain/entities/source.dart';

class Articles extends Equatable {
  const Articles({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  @override
  List<Object> get props {
    return [
      source!,
      author!,
      title!,
      description!,
      url!,
      urlToImage!,
      publishedAt!,
      content!,
    ];
  }

  @override
  bool get stringify => true;
}
