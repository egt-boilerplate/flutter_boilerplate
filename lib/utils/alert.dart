import 'package:flutter/material.dart';

import '../constants/colors.dart';

Future showCustomAlertDialog(
  BuildContext context, {
  Widget? title,
  Widget? content,
  String cancelText = '取消',
  String okText = '确认',
  bool? showCancel = true,
  Function? onOk,
  Function? onCancel,
}) {
  double dialogWidth = MediaQuery.of(context).size.width - 56 * 2;
  bool _inAction = false;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 56),
        title: title,
        content: content,
        actionsOverflowButtonSpacing: 0,
        // actionsPadding: EdgeInsets.zero,
        actions: [
          // 取消按钮
          if (showCancel != false)
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(AppColors.primary),
                fixedSize: MaterialStateProperty.all(
                  Size(dialogWidth / 2 - 24, 44),
                ),
              ),
              onPressed: () async {
                if (!_inAction && onCancel != null) {
                  _inAction = true;
                  var ret = await onCancel();
                  _inAction = false;
                  if (ret == false) {
                    return;
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text(cancelText),
            ),
          // 确认按钮
          TextButton(
            style: ButtonStyle(
              backgroundColor: showCancel == false
                  ? null
                  : MaterialStateProperty.all(AppColors.primary),
              foregroundColor: showCancel == false
                  ? MaterialStateProperty.all(AppColors.primary)
                  : MaterialStateProperty.all(Colors.white),
              fixedSize: MaterialStateProperty.all(
                Size(showCancel == false ? dialogWidth : dialogWidth / 2 - 24,
                    44),
              ),
            ),
            onPressed: () async {
              if (!_inAction && onOk != null) {
                _inAction = true;
                var ret = await onOk();
                _inAction = false;
                if (ret == false) {
                  return;
                }
              }
              Navigator.of(context).pop();
            },
            child: Text(okText),
          ),
        ],
      );
    },
  );
}
