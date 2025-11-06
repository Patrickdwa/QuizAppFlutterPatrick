import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/data/questions.dart';
import 'package:quiz_app_patrick/models/quiz_model.dart';
import 'package:quiz_app_patrick/routes.dart';
import 'package:quiz_app_patrick/screens/result_screen.dart';
import 'package:quiz_app_patrick/widgets/option_tile.dart';
import 'package:quiz_app_patrick/data/questions.dart';
import 'package:quiz_app_patrick/models/quiz_model.dart';

// Class ini akan menyimpan data kuis yang sudah diacak
class _QuizData {
  final String questionText;
  late final List<String> shuffledOptions;
  late final int newCorrectIndex;

  // Konstruktor ini akan langsung mengacak opsi
  _QuizData(Question originalQuestion)
      : questionText = originalQuestion.text {

    // Ambil jawaban yang benar (string-nya) SEBELUM diacak
    final String correctAnswer = originalQuestion.options[originalQuestion.correctAnswerIndex];

    // Buat list baru dari opsi dan acak (shuffle)
    final shuffledList = List<String>.from(originalQuestion.options);
    shuffledList.shuffle();

    // Simpan list yang sudah diacak
    shuffledOptions = shuffledList;

    // Cari di mana posisi jawaban yang benar SEKARANG
    newCorrectIndex = shuffledOptions.indexOf(correctAnswer);
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late String userName;
  int _currentQuestionIndex = 0;
  final Map<int, int> _userAnswers = {}; // <indexSoal, indexJawabanUser>
  // Kita tidak lagi menggunakan 'dummyQuestions' secara langsung.
  // 'quizItems' akan menampung daftar soal DAN opsi yang sudah diacak.
  late List<_QuizData> quizItems;

  @override
  void initState() {
    super.initState();
    // --- (PERUBAHAN 3) Logika Inisialisasi Baru ---
    // A. Buat list baru dari 'dummyQuestions' dan acak urutan SOAL-nya
    final tempShuffledQuestions = List<Question>.from(dummyQuestions);
    tempShuffledQuestions.shuffle();

    // B. Ubah setiap 'Question' yang sudah diacak menjadi '_QuizData'
    //    (Konstruktor '_QuizData' akan otomatis mengacak OPSINYA)
    quizItems = tempShuffledQuestions
        .map((question) => _QuizData(question))
        .toList();
    // --- Akhir Perubahan 3 ---
  }

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
    // --- (PERUBAHAN 4) Gunakan quizItems.length ---
    if (_currentQuestionIndex < quizItems.length - 1) {
      // --- Akhir Perubahan 4 ---
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
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

    // --- (PERUBAHAN 5) Logika Pengecekan Skor Baru ---
    _userAnswers.forEach((questionIndex, answerIndex) {
      // Bandingkan jawaban user dengan 'newCorrectIndex' yang sudah diacak
      if (quizItems[questionIndex].newCorrectIndex == answerIndex) {
        score++;
      }
    });

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.result,
      arguments: ResultScreenArgs(
        name: userName,
        score: score,
        // --- (PERUBAHAN 6) Gunakan quizItems.length ---
        totalQuestions: quizItems.length,
        // --- Akhir Perubahan 6 ---
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- (PERUBAHAN 7) Ambil data dari 'quizItems' ---
    _QuizData currentQuizItem = quizItems[_currentQuestionIndex];
    bool isLastQuestion = _currentQuestionIndex == quizItems.length - 1;
    // --- Akhir Perubahan 7 ---
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
                    // --- (PERUBAHAN 8) Gunakan quizItems.length ---
                    'Question: ${_currentQuestionIndex + 1}/${quizItems.length}',
                    // --- Akhir Perubahan 8 ---
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
                // --- (PERUBAHAN 9) Gunakan currentQuizItem ---
                currentQuizItem.questionText,
                // --- Akhir Perubahan 9 ---
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
              // --- (PERUBAHAN 10) Gunakan currentQuizItem ---
              ...List.generate(currentQuizItem.shuffledOptions.length, (index) {
                return OptionTile(
                  optionText: currentQuizItem.shuffledOptions[index],
                  // --- Akhir Perubahan 10 ---
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
