import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/book.dart';
import 'package:usa_auto_test/models/topic.dart';
import 'package:usa_auto_test/screens/question/components/body.dart';

import '../../models/group.dart';

class QuestionScreen extends StatelessWidget {
  final Topic topic;
  final Book book;
  final Group group;

  const QuestionScreen(
      {super.key,
      required this.topic,
      required this.book,
      required this.group});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(topic: topic, book: book, group: group),
    );
  }
}
