import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/book.dart';
import 'package:usa_auto_test/screens/topic/components/body.dart';

import '../../models/group.dart';

class TopicScreen extends StatelessWidget {
  final Book book;
  final Group group;

  const TopicScreen({
    super.key,
    required this.book,
    required this.group,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        book: book,
        group: group,
      ),
    );
  }
}
