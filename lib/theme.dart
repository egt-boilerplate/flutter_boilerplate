import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/colors.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    primaryColor: AppColors.primary,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white, size: 13),
      actionsIconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        // 中间文字
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        // 边上文字
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevation: 0,
    ),
    dividerColor: AppColors.disabled,
    textTheme: Theme.of(context).textTheme.copyWith(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            // MaterialStateProperty.all<Color>(AppColors.pirmary),
            MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.disabled;
          }
          return AppColors.primary;
        }),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: AppColors.primary)),
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppColors.greyLight,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.disabled,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all<Color>(Colors.white),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primary;
        }
        if (states.contains(MaterialState.disabled)) {
          return AppColors.disabled;
        }
        return AppColors.greyLight;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.primary),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColors.primary,
      unselectedLabelColor: Colors.black,
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      labelStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      labelPadding: EdgeInsets.zero,
    ),
  );
}
