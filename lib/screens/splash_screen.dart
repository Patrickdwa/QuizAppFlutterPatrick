import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness; // deteksi mode terang/gelap
    final isDarkMode = brightness == Brightness.dark;

    final imagePath = isDarkMode
        ? 'assets/images/icons/App Icon - DM.png' // jika dark mode
        : 'assets/images/icons/App Icon - LM.png'; // jika light mode

    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 180),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
