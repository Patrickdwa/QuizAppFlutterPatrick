import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kuis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Tentukan rute awal
      initialRoute: AppRoutes.home,
      // Ambil daftar rute dari file routes.dart
      routes: AppRoutes.routes,
    );
  }
}