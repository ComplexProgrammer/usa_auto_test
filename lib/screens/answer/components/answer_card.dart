import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/answer.dart';
import 'package:usa_auto_test/screens/answer/answer_screen.dart';

class AnswerCard extends StatelessWidget {
  final Answer answer;

  const AnswerCard({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => AnswerScreen(
      //               question: question,
      //             ))),
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
                    fit: BoxFit.fitHeight,
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
