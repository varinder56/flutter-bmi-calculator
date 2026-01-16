import 'package:flutter/material.dart';
import 'package:bmi_var/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green[50]!),
      ),
      home: SplashPage(),
    );
  }
}
