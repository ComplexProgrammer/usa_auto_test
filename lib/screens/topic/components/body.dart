import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/book.dart';
import 'package:usa_auto_test/screens/ads/banner.dart';
import 'package:usa_auto_test/screens/topic/components/backdrop.dart';
import 'package:usa_auto_test/screens/topic/components/topic_carousel.dart';

import '../../../models/group.dart';

class Body extends StatelessWidget {
  final Book book;
  final Group group;

  const Body({
    super.key,
    required this.book,
    required this.group,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Backdrop(
            size: size,
            book: book,
            group: group,
          ),
          TopicCarousel(
            book: book,
            group: group,
          ),
          MyBannerAdWidget(),
        ],
      ),
    );
  }
}
