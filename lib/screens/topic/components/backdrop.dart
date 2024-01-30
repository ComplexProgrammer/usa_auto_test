import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/book.dart';

import '../../../models/group.dart';
import '../../book/book_screen.dart';
import '../topic_screen.dart';

class Backdrop extends StatelessWidget {
  const Backdrop({
    super.key,
    required this.size,
    required this.book,
    required this.group,
  });

  final Size size;
  final Book book;
  final Group group;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.4,
      child: Stack(children: [
        Container(
          height: size.height * 0.4 - 50,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(50)),
            boxShadow: const [kDefaultShadow],
            color: Colors.cyan.withOpacity(0.9),
            image: book.image != ''
                ? DecorationImage(
                    fit: BoxFit.fill,
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
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: size.width * 0.9,
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 50,
                    color: Color(0xFF12153D),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  book.name_en_us,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookScreen(
                  group: group,
                ),
              ),
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 24.0,
              color: Colors.red,
            ),
          ),
        ),
      ]),
    );
  }
}
