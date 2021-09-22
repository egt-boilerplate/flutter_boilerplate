import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import '../api/client.dart';
import '../models/user.dart';
import '../utils/store.dart';

const STORED_TOKEN_KEY = "user.token";
const STORED_USER_KEY = "user.info";

class Authentication {
  static UserEntity? _user;
  static String _token = "";
  static void setUser(UserEntity? user, {bool save = true}) {
    Authentication._user = user;
    // if (save) {
    //   if (user != null) {
    //     SharedPreferencesUtil.saveData<String>(
    //       STORED_USER_KEY,
    //       jsonEncode(
    //         user.toJson(),
    //       ),
    //     );
    //   } else {
    //     SharedPreferencesUtil.removeData(STORED_USER_KEY);
    //   }
    // }
  }

  static UserEntity? getUser() => Authentication._user;

  static void setToken(String token, {bool save = true}) {
    Authentication._token = token;
    if (save) {
      SharedPreferencesUtil.saveData<String>(STORED_TOKEN_KEY, _token);
    }
  }

  static String getToken() => Authentication._token;

  static void clear() {
    Authentication.setToken("");
    Authentication.setUser(null);
  }

  static Future<Tuple2<String, UserEntity>?> init() async {
    // 已有数据
    if (Authentication._token.isNotEmpty && Authentication._user != null) {
      return Tuple2(Authentication._token, Authentication._user!);
    }
    String token = '';
    try {
      token = await SharedPreferencesUtil.getData<String>(STORED_TOKEN_KEY);
    } catch (e) {}
    debugPrint("token: $token");
    if (token.isNotEmpty) {
      Authentication.setToken(token, save: false);
      // String? userStr =
      //     await SharedPreferencesUtil.getData<String?>(STORED_USER_KEY);
      try {
        UserEntity me = await apiClient.getMe();
        Authentication.setUser(me, save: false);
        return Tuple2(token, me);
      } catch (e) {
        debugger();
        print(e);
      }
    }
  }
}
