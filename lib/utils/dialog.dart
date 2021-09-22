import 'package:flutter/material.dart';

import '../constants/colors.dart';

Future showCustomDialog(BuildContext context, Widget child,
    {double? height = 500}) {
  return showGeneralDialog<void>(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Dialog(
        insetPadding: EdgeInsets.all(0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: 343,
              height: height,
              child: child,
            ),
            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.grey,
                ),
              ),
            ),
          ],
        ),
      );
    },
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    // 自定义遮罩颜色
    barrierColor: AppColors.greyLight,
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  // 使用缩放动画
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
