import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/screens/home_screen.dart'; // Pastikan path ini benar
import 'package:quiz_app_patrick/routes.dart';
import 'package:quiz_app_patrick/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
