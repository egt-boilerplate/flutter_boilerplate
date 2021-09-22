import 'package:json_annotation/json_annotation.dart';

part 'upload.g.dart';

@JsonSerializable()
class UploadResp {
  final String url;
  UploadResp({required this.url});
  factory UploadResp.fromJson(Map<String, dynamic> json) =>
      _$UploadRespFromJson(json);

  Map<String, dynamic> toJson() => _$UploadRespToJson(this);
}
