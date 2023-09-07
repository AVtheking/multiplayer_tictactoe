import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<Shadow> shadows;
  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        letterSpacing: 0,
        color: Colors.white,
        fontSize: fontSize,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        shadows: shadows,
      ),
    );
  }
}
