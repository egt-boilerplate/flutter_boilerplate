# flutter_boilerplate
使用Flutter开发

## Flutter环境准备
1. Flutter安装，参考 [https://flutter.cn/docs/get-started/install](https://flutter.cn/docs/get-started/install)
2. VsCode等编辑器配置，参考[https://flutter.cn/docs/get-started/editor?tab=vscode](https://flutter.cn/docs/get-started/editor?tab=vscode)
3. 执行`flutter doctor`后无报错，如果有请根据报错排查问题

## 开发运行
1. VsCode打开项目下`pubspec.yaml`，自动安装依赖，如果没有，请执行`flutter pub get`
2. 启动一个`device`，可以是Android虚拟机、Android真机（打开Adb调试功能）、iOS虚拟机、iOS真机（信任开发电脑），要求执行`flutter devices`时能查看到，如果不能Android请参照`adb`连接教程，iOS一般信任后没问题。
3. 使用命令`flutter run`启动，或者用VsCode的debug模式启动。

### 在web运行
```sh
flutter run -d chrome
```

## 辅助命令
1. 生成 App Launcher Icon
```sh
flutter pub run flutter_launcher_icons:main
```

2. 生成 api
# TODO

3. 生成对象序列化代码
```sh
flutter pub run build_runner watch
```

## 真机安装
- iOS14+
```
flutter run -d [deviceId] --release
```

### 打包开发测试环境
```sh
flutter build apk/ios
```

### 打包线上环境
```sh
flutter build --release apk/ios --dart-define=REQUEST_URL=https://xxx.xxx.xxx/ --dart-define=BUGLY_CHANNEL=prod
```

## 部署

## 依赖更新检测
```
flutter pub outdated
flutter pub upgrade --major-versions
```

## TODO