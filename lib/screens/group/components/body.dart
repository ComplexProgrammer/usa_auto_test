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
      child: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Categorylist(),
            // Genres(),
            SizedBox(height: kDefaultPadding * 4),
            GroupCarousel(),
            // MyBannerAdWidget(),
          ],
        ),
      ),
    );
  }
}
