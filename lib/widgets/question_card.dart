import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String questionText;
  const QuestionCard({super.key, required this.questionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 5)],
      ),
      child: Text(
        questionText,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}