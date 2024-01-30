import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/book.dart';
import 'package:usa_auto_test/models/topic.dart';
import 'package:usa_auto_test/screens/topic/components/topic_card.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import '../../../models/group.dart';

class TopicCarousel extends StatefulWidget {
  final Book book;
  final Group group;
  const TopicCarousel({super.key, required this.book, required this.group});
  @override
  _TopicCaruselState createState() => _TopicCaruselState(book, group);
}

class _TopicCaruselState extends State<TopicCarousel> {
  final Book book;
  final Group group;
  late PageController _pageController;
  int initalPage = 0;
  List<Topic> topics = [];
  Topic topic = Topic(
      id: 0,
      name_en_us: '',
      name_ru_ru: '',
      name_uz_crl: '',
      name_uz_uz: '',
      number: 0,
      image: '');
  var loading = false;

  _TopicCaruselState(this.book, this.group);

  Future<Null> getData() async {
    setState(() {
      loading = true;
    });

    final responseData = await http
        .get(Uri.parse("$baseUrl/GetTopics?book_id=${book.id.toString()}"));
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          topics.add(Topic.fromJson(i));
        }
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    if (topic.id > 0) {
      initalPage = topic.number != 0 ? topic.number - 1 : 0;
    }
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: initalPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: AspectRatio(
              aspectRatio: 0.85,
              child: PageView.builder(
                scrollBehavior: AppScrollBehavior(),
                onPageChanged: (value) {
                  setState(() {
                    initalPage = value;
                    topic = topics[initalPage];
                  });
                },
                controller: _pageController,
                physics: const ClampingScrollPhysics(),
                itemCount: topics.length,
                itemBuilder: (context, index) => buildGroupSlider(index),
              ),
            ),
          );
  }

  Widget buildGroupSlider(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0, page = 0;
        if (_pageController.position.haveDimensions) {
          value = index - _pageController.page!;
          value = (value * 0.038).clamp(-1, 1);
        }
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 350),
          opacity: initalPage == index ? 1 : 0.4,
          child: Transform.rotate(
            angle: math.pi * value,
            child: TopicCard(
              topic: topics[index],
              book: book,
              group: group,
            ),
          ),
        );
      },
    );
  }
}
