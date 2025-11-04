import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _isButtonEnabled = _nameController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_isButtonEnabled) {
      Navigator.pushNamed(
        context,
        AppRoutes.quiz,
        arguments: _nameController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // button gak ikut :)
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align ke kiri
          children: [
            const SizedBox(height: 80), // Jarak dari atas

            Text(
              'Welcome to Quizzer',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Please Enter your name below to get started',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40), // Jarak ke input field

            Text(
              'Your name',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name', // Placeholder
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // Hapus garis border
                ),
                filled: true,
                fillColor: Colors.grey[200], // Warna background input field
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const Spacer(), // Mendorong tombol ke bagian bawah

            SizedBox(
              width: double.infinity, // Membuat tombol full width
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? _startQuiz : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600], // Warna biru untuk tombol
                  foregroundColor: Colors.white, // Warna teks tombol
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                  disabledBackgroundColor: Colors.blue.withValues(alpha: 0.3), // Warna tombol disabled
                  disabledForegroundColor: Colors.white.withValues(alpha: 0.7), // Warna teks tombol disabled
                ),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36), // Padding bawah untuk tombol
          ],
        ),
      ),
    );
  }
}