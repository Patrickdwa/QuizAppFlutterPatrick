import 'dart:async'; // Diperlukan untuk Timer
import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/routes.dart/';

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
        /* pushReplacementNamed agar pengguna tidak bisa menekan tombol 'back'
        dan kembali ke splash screen.*/
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icons/App Icon - LM.png',
              width: 180,
              // height: 180,
            ),
            const SizedBox(height: 24),
            // Indikator loading
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Ubah warna agar kontras
            ),
          ],
        ),
      ),
    );
  }
}