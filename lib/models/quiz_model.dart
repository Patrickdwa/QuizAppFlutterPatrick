class Question {
  final String text;
  final List<String> options; // Daftar pilihan jawaban, misal [A, B, C, D]
  final int correctAnswerIndex; // Indeks dari jawaban yang benar (0, 1, 2, atau 3)

  const Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}