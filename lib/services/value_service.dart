import 'dart:math';

import 'package:bmicalculator/ui/themes.dart';
import 'package:flutter/material.dart';

class ValueService extends ChangeNotifier {
  int _height = 190;
  int _weight = 60;

  Color _maleBoxColor = Themes.activeColor;
  Color _femaleBoxColor = Themes.inActiveColor;

  double _bmi = 0;
  String _bmiResult = "";

  double get bmi => _bmi;

  String get bmiResult => _bmiResult;

  int _age = 22;

  int get height => _height;

  int get weight => _weight;

  int get age => _age;

  Color get maleBoxColor => _maleBoxColor;

  Color get femaleBoxColor => _femaleBoxColor;

  void incrementHeight() {
    _height++;
    notifyListeners();
  }

  void decrementHeight() {
    _height--;
    notifyListeners();
  }

  void incrementWeight() {
    _weight++;
    notifyListeners();
  }

  void decrementWeight() {
    _weight--;
    notifyListeners();
  }

  void incrementAge() {
    _age++;
    notifyListeners();
  }

  void decrementAge() {
    _age--;
    notifyListeners();
  }

  void updateBoxColor(int gender) {
    if (gender == 1) {
      if (_maleBoxColor == Themes.inActiveColor) {
        _maleBoxColor = Themes.activeColor;
        _femaleBoxColor = Themes.inActiveColor;
      } else {
        _maleBoxColor = Themes.inActiveColor;
        _femaleBoxColor = Themes.activeColor;
      }
    } else {
      if (_femaleBoxColor == Themes.inActiveColor) {
        _femaleBoxColor = Themes.activeColor;
        _maleBoxColor = Themes.inActiveColor;
      } else {
        _femaleBoxColor = Themes.inActiveColor;
        _maleBoxColor = Themes.activeColor;
      }
    }

    notifyListeners();
  }

  void calculateBmi() {
    _bmi = _weight / pow(_height / 100, 2);
    notifyListeners();
  }

  void getInterpretation() {
    if (_bmi >= 30.0) {
      _bmiResult =
          "You have a higher weight than a Normal body weight which caused Obesity. You need to work more to reduce obesity";
    } else if (_bmi >= 25.0) {
      _bmiResult =
          "You have a higher weight than a normal body weight. Should Exercise a bit more";
    } else if (_bmi >= 18.5) {
      _bmiResult = "You have a Normal body weight. Keep yourself Fit";
    } else {
      _bmiResult =
          "You are underweight, you need to eat more Fruits and Vegetables";
    }
    notifyListeners();
  }
}
