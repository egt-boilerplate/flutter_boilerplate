import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/upload.dart';
import '../models/user.dart';

part 'client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient({Dio? dio, String? baseUrl}) {
    dio ??= baseDio;
    return _RestClient(dio, baseUrl: baseUrl);
  }

  @POST('/files/upload')
  Future<UploadResp> upload(@Part() File file);

  @POST('/login')
  Future<UserEntity> login(@Body() Map<String, String> map);

  // 发送验证码
  @POST('/auth/send-sms')
  Future sendSms(@Body() Map<String, String> map);

  // 设置新密码
  @POST('/auth/reset-password')
  Future setNewPassword(@Body() Map<String, String> map);
}

RestClient apiClient = RestClient();
