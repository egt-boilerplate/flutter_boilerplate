import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tuple/tuple.dart';

import '../api/client.dart';
import '../models/user.dart';
import 'auth.dart';

class UserState extends ChangeNotifier {
  UserEntity? _user;
  String _token = "";
  bool _initialized = false;

  UserEntity? get user => _user;
  bool get logged => _token != "" && _user != null;
  bool get initialized => _initialized;

  Future init() async {
    Tuple2<String, UserEntity>? stored = await Authentication.init();
    _initialized = true;
    if (stored != null) {
      _onLoginSuccess(stored.item1, stored.item2);
    } else {
      notifyListeners();
    }
  }

  void _onLoginSuccess(String token, UserEntity user) {
    _token = token;
    _user = user;
    Authentication.setToken(_token);
    Authentication.setUser(user);
    notifyListeners();
  }

  Future<bool> login(String username, String password) {
    return apiClient
        .login({"mobile": username, "password": password}).then((resp) {
      _onLoginSuccess(
        resp.accessToken!,
        resp,
      );
      return true;
    }).catchError((Object e) {
      switch (e.runtimeType) {
        case DioError:
          EasyLoading.showToast((e as DioError).message);
          break;
        default:
          print(e);
      }
      return false;
    });
  }

  logout() {
    _token = "";
    _user = null;

    Authentication.clear();
    notifyListeners();
  }

  updateMe(UserEntity newUser) {
    _user = newUser;
    Authentication.setUser(newUser);
    notifyListeners();
  }

  Future refreshMe() async {
    try {
      var resp = await apiClient.getMe();
      updateMe(resp);
    } catch (e) {}
  }
}
