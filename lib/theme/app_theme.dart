import 'package:flutter/material.dart';
import 'package:nvp_test/theme/app_color.dart';

import 'app_fontsize.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
    inputDecorationTheme:
        const InputDecorationTheme(labelStyle: TextStyle(color: Colors.blue)),
    textTheme: const TextTheme(
        titleLarge: TextStyle(color: textPrimary, fontSize: 18),
        titleSmall: TextStyle(color: textPrimary, fontSize: 14),
        bodyMedium:
            TextStyle(color: Color(0xffEEEEEE), fontSize: FontSizes.small),
        bodySmall:
            TextStyle(color: Color(0xff000000), fontSize: FontSizes.small)),
    colorScheme: const ColorScheme.light(
        background: Colors.white,
        primary: primaryColor,
        secondary: Colors.white));

ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
        titleLarge: TextStyle(color: Color(0xffEEEEEE), fontSize: 18),
        titleSmall: TextStyle(color: Color(0xffEEEEEE), fontSize: 14),
        bodyMedium:
            TextStyle(color: Color(0xffEEEEEE), fontSize: FontSizes.small),
        bodySmall:
            TextStyle(color: Color(0xff000000), fontSize: FontSizes.small)),
    colorScheme: const ColorScheme.dark(
        background: Color(0xff1E201E),
        primary: Colors.black,
        secondary: Color.fromARGB(255, 46, 48, 46)));
