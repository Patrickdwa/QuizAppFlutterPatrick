import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/routes.dart';

// Class helper untuk menerima argumen navigasi
class ResultScreenArgs {
  final String name;
  final int score;
  final int totalQuestions;

  ResultScreenArgs({
    required this.name,
    required this.score,
    required this.totalQuestions,
  });
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ekstrak argumen yang dikirim dari QuizScreen
    final args = ModalRoute.of(context)!.settings.arguments as ResultScreenArgs;

    double percentage = (args.score / args.totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
        automaticallyImplyLeading: false, // Sembunyikan tombol back
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selamat, ${args.name}!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Anda bisa menggunakan ScoreBadge di sini
              Text(
                'Skor Anda:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '${args.score} / ${args.totalQuestions}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: percentage > 60 ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Ulangi kuis dengan nama yang sama
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.quiz,
                    arguments: args.name,
                  );
                },
                child: const Text('Ulangi Kuis'),
              ),
              OutlinedButton(
                onPressed: () {
                  // Kembali ke Beranda (clear stack navigasi)
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                        (route) => false, // Hapus semua rute sebelumnya
                  );
                },
                child: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}