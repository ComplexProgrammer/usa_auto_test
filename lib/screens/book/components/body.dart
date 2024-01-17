import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/group.dart';
import 'package:usa_auto_test/screens/ads/banner.dart';
import 'package:usa_auto_test/screens/book/components/backdrop.dart';
import 'package:usa_auto_test/screens/book/components/book_carousel.dart';

class Body extends StatelessWidget {
  final Group group;

  const Body({super.key, required this.group});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Backdrop(size: size, group: group),
          // Padding(
          //   padding: const EdgeInsets.all(kDefaultPadding),
          //   child: Column(
          //     children: [
          //       Text(
          //         "Fanni tanlang",
          //         style: Theme.of(context).textTheme.headline5,
          //       ),
          //     ],
          //   ),
          // ),
          BookCarousel(
            group: group,
          ),
          MyBannerAdWidget(),
          // _showInterstitialAd(),
        ],
      ),
    );
  }
}
