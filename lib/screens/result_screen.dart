import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/routes.dart';

// Class helper untuk menerima argumen navigasi (Tidak berubah)
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

  // Helper widget untuk membangun Indikator Skor
  Widget _buildScoreIndicator(BuildContext context, int score, int total) {
    double percentage = total > 0 ? (score / total) : 0;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Cincin progress
        SizedBox(
          width: 160,
          height: 160,
          child: CircularProgressIndicator(
            value: percentage,
            strokeWidth: 12, // Ketebalan cincin
            backgroundColor: Colors.grey[200], // Warna latar belakang cincin
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!), // Warna progress
          ),
        ),
        // Teks di dalam cincin
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$score/$total',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              'Score',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper widget untuk tombol "Retry Quiz"
  Widget _buildRetryButton(BuildContext context, String name) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.refresh, color: Colors.white), // Ikon
        label: const Text(
          'Retry Quiz',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          // Ulangi kuis dengan nama yang sama
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.quiz,
            arguments: name,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[600], // Warna background
          foregroundColor: Colors.white, // Warna teks & ikon
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Sudut membulat
          ),
        ),
      ),
    );
  }

  // Helper widget untuk tombol "Back to home"
  Widget _buildHomeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(Icons.home_outlined, color: Colors.blue[600]), // Ikon
        label: Text(
          'Back to home',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blue[600], // Warna teks
          ),
        ),
        onPressed: () {
          // Kembali ke Beranda (clear stack navigasi)
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
                (route) => false, // Hapus semua rute sebelumnya
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blue[600], // Warna ikon saat ditekan
          side: BorderSide(color: Colors.blue[600]!, width: 2), // Garis tepi
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Sudut membulat
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ekstrak argumen yang dikirim dari QuizScreen
    final args = ModalRoute.of(context)!.settings.arguments as ResultScreenArgs;

    return Scaffold(
      // Hapus AppBar
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Padding untuk seluruh layar
        child: Column(
          children: [
            const Spacer(flex: 2), // Beri jarak dari atas

            // 1. Indikator Skor
            _buildScoreIndicator(context, args.score, args.totalQuestions),

            const SizedBox(height: 32),

            // 2. Teks Ucapan Selamat
            Text(
              'Congratulation',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Great job, ${args.name}! You Did It',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(flex: 3), // Dorong tombol ke bawah

            // 3. Tombol Aksi
            _buildRetryButton(context, args.name),
            const SizedBox(height: 12),
            _buildHomeButton(context),

            const SizedBox(height: 36), // Padding di bawah
          ],
        ),
      ),
    );
  }
}