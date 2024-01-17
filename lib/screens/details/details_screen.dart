import 'package:flutter/material.dart';
import 'package:usa_auto_test/models/group.dart';
import 'package:usa_auto_test/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Group group;

  const DetailsScreen({super.key, required this.group});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        group: group,
      ),
    );
  }
}
