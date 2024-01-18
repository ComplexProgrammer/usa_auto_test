import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/book.dart';
import 'package:usa_auto_test/screens/book/components/book_carousel.dart';
import 'package:usa_auto_test/screens/topic/topic_screen.dart';

import '../../../models/group.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final Group group;
  const BookCard({super.key, required this.book, required this.group});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TopicScreen(
                      book: book,
                      group: group,
                    )))
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              child: Text(
                book.name_en_us,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [kDefaultShadow],
                  color: Colors.cyan,
                  image: book.image != ''
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('$baseUrl/media/${book.image}'),
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
        ),
      ),
    );
  }
}
