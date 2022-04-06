import 'package:bmicalculator/ui/themes.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final Function() onTapped;

  const MyButton({
    Key? key,
    required this.buttonText,
    required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onTapped,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 22.0,
              letterSpacing: 0.8,
            ),
          ),
        ),
        style: Themes().elevatedButonStyle,
      ),
    );
  }
}
