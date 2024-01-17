import 'package:flutter/material.dart';
import 'package:usa_auto_test/models/group.dart';
import 'package:usa_auto_test/screens/book/components/body.dart';

class BookScreen extends StatelessWidget {
  final Group group;
  @override
  const BookScreen({super.key, required this.group});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        group: group,
      ),
    );
  }
}
