import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/group.dart';
import 'package:usa_auto_test/screens/group/components/group_card.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class GroupCarousel extends StatefulWidget {
  const GroupCarousel({super.key});

  @override
  _GroupCaruselState createState() => _GroupCaruselState();
}

class _GroupCaruselState extends State<GroupCarousel> {
  late PageController _pageController;
  int initalPage = 0;
  List<Group> groups = [];
  Group group = Group(id: 0, name_en_us: '');
  var loading = false;

  Future<void> getData() async {
    setState(() {
      loading = true;
    });

    final responseData =
        await http.get(Uri.parse("$baseUrl/tests/GetGroups/?type_id=3"));
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          groups.add(Group.fromJson(i));
        }
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    if (group.id > 0) {
      initalPage = group.number != 0 ? group.number! - 1 : 0;
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
              aspectRatio: 1.05,
              child: PageView.builder(
                scrollBehavior: AppScrollBehavior(),
                onPageChanged: (value) {
                  setState(() {
                    initalPage = value;
                    group = groups[initalPage];
                  });
                },
                controller: _pageController,
                physics: const ClampingScrollPhysics(),
                itemCount: groups.length,
                itemBuilder: (context, index) => buildGroupSlider(index),
              ),
            ),
          );
  }

  Widget buildGroupSlider(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0;
        if (_pageController.position.haveDimensions) {
          value = index - _pageController.page!;
          value = (value * 0.038).clamp(-1, 1);
        }
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 350),
          opacity: initalPage == index ? 1 : 0.4,
          child: Transform.rotate(
            angle: math.pi * value,
            child: GroupCard(
              group: groups[index],
            ),
          ),
        );
      },
    );
  }
}
