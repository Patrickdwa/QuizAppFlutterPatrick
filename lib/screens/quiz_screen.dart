import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/data/questions.dart';
import 'package:quiz_app_patrick/models/quiz_model.dart';
import 'package:quiz_app_patrick/routes.dart';
import 'package:quiz_app_patrick/screens/result_screen.dart';
import 'package:quiz_app_patrick/widgets/option_tile.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late String userName;
  int _currentQuestionIndex = 0;
  final Map<int, int> _userAnswers = {}; // <indexSoal, indexJawabanUser>

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userName = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
  }

  void _selectOption(int index) {
    setState(() {
      // Simpan jawaban untuk soal saat ini
      _userAnswers[_currentQuestionIndex] = index;
    });
  }

  void _nextQuestion() {
    // Pindah ke pertanyaan berikutnya
    if (_currentQuestionIndex < dummyQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Kuis selesai, hitung skor dan navigasi ke hasil
      _submitQuiz();
    }
  }

  // Fungsi baru untuk 'Previous Question'
  void _prevQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _submitQuiz() {
    int score = 0;
    _userAnswers.forEach((questionIndex, answerIndex) {
      if (dummyQuestions[questionIndex].correctAnswerIndex == answerIndex) {
        score++;
      }
    });

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

    int? selectedOptionIndex = _userAnswers[_currentQuestionIndex];
    bool isOptionSelected = selectedOptionIndex != null;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. BARIS INDIKATOR PROGRESS & TOMBOL NAVIGASI (PERUBAHAN DI SINI)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Indikator Progress
                  Text(
                    'Question: ${_currentQuestionIndex + 1}/${dummyQuestions
                        .length}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600, // SemiBold
                    ),
                  ),

                  // Grup Tombol Previous & Next
                  Row(
                    children: [
                      // Tombol Previous
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        // Nonaktifkan jika ini soal pertama
                        onPressed: _currentQuestionIndex > 0
                            ? _prevQuestion
                            : null,
                      ),
                      const SizedBox(width: 8),
                      // Tombol Next
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 18),
                        // Nonaktifkan jika ini soal terakhir
                        onPressed: !isLastQuestion ? _nextQuestion : null,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Teks Pertanyaan
              Text(
                currentQuestion.text,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                  fontWeight: FontWeight.w600, // SemiBold
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 32),

              // 3. Daftar Pilihan
              ...List.generate(currentQuestion.options.length, (index) {
                return OptionTile(
                  optionText: currentQuestion.options[index],
                  isSelected: selectedOptionIndex == index,
                  onTap: () => _selectOption(index),
                );
              }),

              const Spacer(),
              // Mendorong tombol ke bawah

              // 4. TOMBOL SUBMIT (HANYA MUNCUL DI SOAL TERAKHIR)
              // Logika ini akan menampilkan tombol Submit jika di soal terakhir,
              // dan widget kosong jika tidak.
              if (isLastQuestion)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isOptionSelected ? _submitQuiz : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      // disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: const Text(
                      'Submit Quiz',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600, // SemiBold
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
