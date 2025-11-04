import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/data/questions.dart';
import 'package:quiz_app_patrick/models/quiz_model.dart';
import 'package:quiz_app_patrick/routes.dart';
import 'package:quiz_app_patrick/screens/result_screen.dart'; // Import ResultScreenArgs

// Widget dan file lain yang diperlukan (dibuat sebagai placeholder)
import 'package:quiz_app_patrick/widgets/question_card.dart';
import 'package:quiz_app_patrick/widgets/option_tile.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late String userName;
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex; // Indeks jawaban yang dipilih user
  final Map<int, int> _userAnswers = {}; // <indexSoal, indexJawabanUser>

  // Ambil nama dari argumen navigasi
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userName = ModalRoute.of(context)!.settings.arguments as String;
  }

  void _selectOption(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _nextQuestion() {
    // Simpan jawaban user
    if (_selectedOptionIndex != null) {
      _userAnswers[_currentQuestionIndex] = _selectedOptionIndex!;
    }

    // Pindah ke pertanyaan berikutnya
    if (_currentQuestionIndex < dummyQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null; // Reset pilihan
      });
    } else {
      // Kuis selesai, hitung skor dan navigasi ke hasil
      _submitQuiz();
    }
  }

  void _submitQuiz() {
    int score = 0;
    _userAnswers.forEach((questionIndex, answerIndex) {
      if (dummyQuestions[questionIndex].correctAnswerIndex == answerIndex) {
        score++;
      }
    });

    // Navigasi ke Halaman Hasil dan kirim data
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.result,
      arguments: ResultScreenArgs(
        name: userName,
        score: score,
        totalQuestions: dummyQuestions.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = dummyQuestions[_currentQuestionIndex];
    bool isLastQuestion = _currentQuestionIndex == dummyQuestions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Soal ${_currentQuestionIndex + 1} / ${dummyQuestions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Kartu Pertanyaan (Widget Kustom)
            QuestionCard(questionText: currentQuestion.text),
            const SizedBox(height: 20),

            // 2. Daftar Pilihan (Widget Kustom)
            ...List.generate(currentQuestion.options.length, (index) {
              return OptionTile(
                optionText: currentQuestion.options[index],
                isSelected: _selectedOptionIndex == index,
                onTap: () => _selectOption(index),
              );
            }),

            const Spacer(), // Dorong tombol ke bawah

            // 3. Tombol Next / Submit
            ElevatedButton(
              onPressed: _selectedOptionIndex != null ? _nextQuestion : null,
              child: Text(isLastQuestion ? 'Submit' : 'Next'),
            ),
          ],
        ),
      ),
    );
  }
}