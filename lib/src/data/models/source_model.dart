import 'package:flutter_clean_architecture/src/domain/entities/source.dart';

class SourceModel extends Source {
  const SourceModel({
    int? id,
    String? name,
  }) : super(
          id: id,
          name: name,
        );

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}