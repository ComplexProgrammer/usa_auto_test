import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/question.dart';
import 'package:usa_auto_test/screens/answer/components/body.dart';

class AnswerScreen extends StatelessWidget {
  final Question question;

  const AnswerScreen({super.key, required this.question});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        question: question,
      ),
    );
  }
}
