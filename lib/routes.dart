import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/screens/home_screen.dart';
import 'package:quiz_app_patrick/screens/quiz_screen.dart';
import 'package:quiz_app_patrick/screens/result_screen.dart';

class AppRoutes {
  // Nama rute statis agar tidak salah ketik
  static const String home = '/';
  static const String quiz = '/quiz';
  static const String result = '/result';

  // Peta (Map) yang menghubungkan nama rute ke widget Halaman
  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomeScreen(),
      quiz: (context) => const QuizScreen(),
      result: (context) => const ResultScreen(),
    };
  }
}