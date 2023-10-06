import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answer;
  final bool isCorrect;

  const Answer({
    required this.answer,
    required this.isCorrect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isCorrect ? correctAnswer() : falseAnswer(),
        const SizedBox(width: 4),
        Text(answer),
      ],
    );
  }

  Widget correctAnswer() {
    return const Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Widget falseAnswer() {
    return const Icon(
      Icons.close,
      color: Colors.red,
    );
  }
}
