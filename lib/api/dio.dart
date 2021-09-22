import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class _Http {
  late Dio dio;
  _Http() {
    dio = Dio(
      BaseOptions(
        baseUrl: "$BASE_URL/api/",
      ),
    );
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = jsonDecode;
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        String token = Authentication.getToken();
        if (token != '') {
          options.headers['Authorization'] = 'Bearer $token';
        }
        // Do something before request is sent
        return handler.next(options); //continue
        // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
        //
        // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      }, onResponse: (response, handler) {
        // Do something with response data

        response.data = response.data['data'];
        return handler.next(response);
        // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      }, onError: (DioError e, handler) {
        // debugger();
        if (e.response != null) {
          int code = e.response!.statusCode!;
          String? message = e.response!.data['message'];
          if (code == 401) {
            if (!e.response!.requestOptions.path.endsWith('/login')) {
              EasyLoading.showError("登录过期，请重新登录");
              // 登录过期跳登录页面
              if (navigatorKey.currentContext != null &&
                  ModalRoute.of(navigatorKey.currentContext!)!.settings.name !=
                      '/login') {
                Future.delayed(Duration(milliseconds: 500)).then((value) {
                  navigatorKey.currentState?.pushReplacementNamed('/login');
                });
              }
            }
            Authentication.clear();

            return handler.reject(
              DioError(
                requestOptions: e.response!.requestOptions,
                error: message ?? '登录过期',
              ),
            );
          } else {
            if (message != null) {
              EasyLoading.showError(message);
            }
            return handler.reject(
              DioError(
                requestOptions: e.response!.requestOptions,
                error: message ?? '系统错误',
              ),
            );
          }
        }
        // Do something with response error
        return handler.next(e); //continue
        // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      }),
    );
  }
}

final Dio baseDio = _Http().dio;
