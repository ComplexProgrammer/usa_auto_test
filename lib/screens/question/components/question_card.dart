import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/question.dart';
import 'package:usa_auto_test/screens/answer/answer_screen.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AnswerScreen(
                    question: question,
                  ))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [kDefaultShadow],
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        '$baseUrl/tests/types/images/autotest.jpg'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
