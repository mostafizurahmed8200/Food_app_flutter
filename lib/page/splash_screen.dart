import 'package:flutter/material.dart';
import 'package:food_apps/assets/const.dart';

import 'intropage1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(
    //   const Duration(seconds: 5),
    //   () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const IntroScreen(),
    //     ),
    //   ),
    // );

    _navigateToIntro();
  }

  void _navigateToIntro() async {
    await Future.delayed(const Duration(seconds: 1)); // R
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const IntroScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(Const.logo),
      ),
    );
  }
}
