import 'package:flutter/material.dart';
import 'package:quiz_app_patrick/routes.dart';

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

  Widget _buildScoreIndicator(BuildContext context, int score, int total) {
    final cs = Theme.of(context).colorScheme;
    double percentage = total > 0 ? (score / total) : 0;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: CircularProgressIndicator(
            value: percentage,
            strokeWidth: 12,
            backgroundColor: cs.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$score/$total',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
            Text(
              'Score',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: cs.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRetryButton(BuildContext context, String name) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(Icons.refresh, color: cs.onPrimary),
        label: const Text(
          'Retry Quiz',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.quiz,
            arguments: name,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(Icons.home_outlined, color: cs.primary),
        label: Text(
          'Back to home',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: cs.primary),
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.primary, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ResultScreenArgs;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(flex: 2),
            _buildScoreIndicator(context, args.score, args.totalQuestions),
            const SizedBox(height: 32),
            Text(
              'Congratulation',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Great job, ${args.name}! You Did It',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: cs.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 3),
            _buildRetryButton(context, args.name),
            const SizedBox(height: 12),
            _buildHomeButton(context),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
