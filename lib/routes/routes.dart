import 'package:bmicalculator/ui/screens/home_screen.dart';
import 'package:bmicalculator/ui/screens/result_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String homeScreen = "/";
  static const String resultScreen = "/resultScreen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case resultScreen:
        return MaterialPageRoute(
          builder: (context) => const ResultScreen(),
        );
      default:
        throw const FormatException("Route Not Found! Check Again");
    }
  }
}
