import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/screens/ads/banner.dart';
import 'package:usa_auto_test/screens/group/components/categories.dart';
import 'package:usa_auto_test/screens/group/components/group_carousel.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(
      //       'assets/images/img.jpg',
      //     ),
      //     fit: BoxFit.scaleDown,
      //   ),
      // ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Categorylist(),
            // Genres(),
            const SizedBox(height: kDefaultPadding * 4),
            const GroupCarousel(),
            MyBannerAdWidget(),
          ],
        ),
      ),
    );
  }
}
