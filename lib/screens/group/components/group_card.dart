import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/group.dart';
import 'package:usa_auto_test/screens/book/book_screen.dart';
import 'package:usa_auto_test/screens/details/details_screen.dart';

class GroupCard extends StatelessWidget {
  final Group group;

  const GroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookScreen(
                      group: group,
                    ))),
        child: buildGroupCard(context),
      ),
    );
  }

  Column buildGroupCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          child: Text(
            group.name_en_us,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [kDefaultShadow],
              color: Colors.greenAccent,
              image: group.image != ''
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("$baseUrl/media/${group.image}"),
                    )
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
    );
  }
}
