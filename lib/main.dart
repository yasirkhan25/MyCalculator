import 'package:flutter/material.dart';
import 'package:my_calculator/splash_screen.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

