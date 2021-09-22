import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserEntity {
  final int id;
  final String name;
  final String mobile;
  final String avatar;
  // token
  final String? accessToken;

  const UserEntity({
    required this.id,
    required this.name,
    required this.mobile,
    required this.avatar,
    this.accessToken,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

@JsonSerializable()
class ChildEntity {
  String name;
  String? school;
  String? grade;
  int? classNumber;
  ChildEntity({
    required this.name,
    this.school,
    this.grade,
    this.classNumber,
  });
  factory ChildEntity.fromJson(Map<String, dynamic> json) =>
      _$ChildEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChildEntityToJson(this);
}
