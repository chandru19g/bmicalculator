import 'package:flutter/material.dart';

class Themes {
  static const Color primaryClr = Colors.green;
  static const Color darkGreyClr = Color(0xFF121212);
  static const Color darkHeaderClr = Color(0xFF424242);

  static const activeColor = Colors.green;
  static const inActiveColor = Colors.transparent;

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryClr,
    scaffoldBackgroundColor: darkGreyClr,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkGreyClr,
    ),
  );

  TextStyle get headerStyle {
    return const TextStyle(
      fontSize: 20.0,
      letterSpacing: 0.8,
    );
  }

  ButtonStyle get buttonStyle {
    return ElevatedButton.styleFrom(
      primary: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      elevation: 0.0,
    );
  }

  ButtonStyle get elevatedButonStyle {
    return ElevatedButton.styleFrom(
      primary: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    );
  }

  TextStyle get valueStyle {
    return const TextStyle(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
    );
  }
}
