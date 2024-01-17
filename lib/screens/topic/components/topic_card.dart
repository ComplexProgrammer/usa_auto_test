import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/book.dart';
import 'package:usa_auto_test/models/topic.dart';
import 'package:usa_auto_test/screens/question/question_screen.dart';

import '../../../models/group.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final Book book;
  final Group group;
  const TopicCard(
      {super.key,
      required this.topic,
      required this.book,
      required this.group});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuestionScreen(
                    topic: topic,
                    book: book,
                    group: group,
                  ))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              child: Text(
                topic.name_en_us,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [kDefaultShadow],
                  color: const Color(0xfff709090),
                  image: topic.image != ''
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('$baseUrl/media/${topic.image}'))
                      : const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/img.jpg',
                          ),
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
