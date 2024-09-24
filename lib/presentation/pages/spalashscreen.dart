// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quad/presentation/pages/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.3, 
            child: Image(
              image: AssetImage('assets/allSaints.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
          // Centered content
          Center(
            child: Image(
              image: AssetImage('assets/allSaints.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
