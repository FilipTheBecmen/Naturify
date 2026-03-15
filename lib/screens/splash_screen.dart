import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    // executed when the widget is first created
    super.initState();
    //Splash screen will be shown for 2 seconds, then navigate to home page
    _timer = Timer(const Duration(seconds: 3), () {
      //navigate to home page and remove splash screen from the stack
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel(); // Cancel the timer when disposing the widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 191, 99),
      body: Center(
        child: Image.asset("assets/images/logo.png", width: 200, height: 200),
      ),
    );
  }
}
