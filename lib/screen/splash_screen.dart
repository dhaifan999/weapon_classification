import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weapon_classification/screen/bottom_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToScreen();
    super.initState();
  }

  void goToScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavbar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/img/icon.png'),
          height: 150,
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
