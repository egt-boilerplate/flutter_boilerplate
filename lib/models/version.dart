import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

@JsonSerializable()
class VersionInfo {
  final String version;
  final bool isForce;
  final String? description;
  const VersionInfo({
    required this.version,
    required this.isForce,
    required this.description,
  });
  factory VersionInfo.fromJson(Map<String, dynamic> json) =>
      _$VersionInfoFromJson(json);

  /// 是否比老版本新
  bool isNewerThan(String oldVersion) {
    var oldSplited = oldVersion.split('.');
    var splited = this.version.split('.');
    for (var i = 0; i < splited.length; i++) {
      if (int.parse(splited[i]) > int.parse(oldSplited[i])) {
        return true;
      }
    }
    return false;
  }
}
