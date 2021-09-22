import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/app.dart';
import '../models/version.dart';
import '../utils/alert.dart';

class VersionUpdateTask {
  static bool _running = false;
  static checkVersion(BuildContext context) async {
    if (VersionUpdateTask._running) return;
    VersionUpdateTask._running = true;
    try {
      Response resp = await Dio().get(
          '$VERSION_DOWNLOAD_URL/version.json?t=${DateTime.now().millisecondsSinceEpoch}');
      late VersionInfo newVersion;
      if (Platform.isAndroid) {
        newVersion = VersionInfo.fromJson(resp.data['android']);
      } else if (Platform.isIOS) {
        newVersion = VersionInfo.fromJson(resp.data['ios']);
      }
      PackageInfo pkg = await PackageInfo.fromPlatform();
      // ignore: unnecessary_null_comparison
      if (newVersion != null && newVersion.isNewerThan(pkg.version)) {
        showCustomAlertDialog(
          context,
          title: Text('升级提示'),
          content: Text('本次升级内容：\n\n${newVersion.description ?? '修复一些已知问题'}'),
          okText: '更新',
          onOk: () async {
            // 有更新
            if (Platform.isIOS) {
              try {
                if (await Permission.storage.request().isGranted) {
                  var temp = await getTemporaryDirectory();
                  String apkPath = '$temp/${newVersion.version}/$APP_NAME.apk';
                  await Dio().download(
                      '$VERSION_DOWNLOAD_URL/${newVersion.version}/$APP_NAME.apk',
                      apkPath);
                  await InstallPlugin.installApk(apkPath, APPLICATION_ID);
                } else {
                  EasyLoading.showSuccess('已被禁止存储权限，请自行前往官网更新');
                }
              } catch (e) {
                print('Install error:');
                print(e);
              }
              // InstallPlugin.gotoAppStore(APP_STORE_URL);
            } else {
              try {
                if (await Permission.storage.request().isGranted) {
                  var folder = await getExternalStorageDirectory();
                  String apkPath =
                      '${folder!.absolute.path}/${newVersion.version}.apk';
                  await Dio().download(
                      '$VERSION_DOWNLOAD_URL/${newVersion.version}/$APP_NAME.apk',
                      apkPath, onReceiveProgress: (cur, total) {
                    EasyLoading.showProgress(cur / total);
                  });
                  EasyLoading.dismiss();
                  if (await Permission.requestInstallPackages
                      .request()
                      .isGranted) {
                    await InstallPlugin.installApk(apkPath, APPLICATION_ID);
                  } else {
                    EasyLoading.showError('安装失败');
                  }
                } else {
                  EasyLoading.showSuccess('已被禁止存储权限，请自行前往官网更新');
                }
              } catch (e) {
                print('Install error:');
                print(e);
              }
            }
          },
          showCancel: !newVersion.isForce,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
