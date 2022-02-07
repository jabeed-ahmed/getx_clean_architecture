import 'package:equatable/equatable.dart';

class Source extends Equatable {
  const Source({
    this.id,
    this.name,
  });
  final int? id;
  final String? name;

  @override
  List<Object> get props {
    return [
      id!,
      name!,
    ];
  }

  @override
  bool get stringify => true;
}
