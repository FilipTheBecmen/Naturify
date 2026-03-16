import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naturify/screens/splash_screen.dart';

const Color appBackground = Color.fromARGB(255, 65, 136, 102);

void main() {
  runApp(const SplashScreenApp());
}

class SplashScreenApp extends StatefulWidget {
  const SplashScreenApp({super.key});

  @override
  State<SplashScreenApp> createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: appBackground,
        canvasColor: appBackground,
        colorScheme: const ColorScheme.dark(surface: appBackground),
      ),
      home: SplashScreen(),
    );
  }
}
