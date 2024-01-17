import 'package:flutter/material.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/screens/group/components/body.dart';

class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: const IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: Icon(Icons.menu),
        onPressed: null,
      ),
      actions: const <Widget>[
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.telegram,
          ),
        )
      ],
    );
  }
}
