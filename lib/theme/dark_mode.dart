import 'package:flutter/material.dart';

ThemeData darkMode=ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface:Colors.grey.shade900,
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade500,
        inversePrimary: Colors.grey.shade800
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor:  Colors.grey,
      displayColor: Colors.white,
    )
);