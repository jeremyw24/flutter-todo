import 'package:flutter/material.dart';

class Widgets {
  Widget mainAppBar() {
    return AppBar(
      title: Text('Flutter To Do App'),
      actions: [
        IconButton(
          alignment: Alignment.center,
          icon: Image.asset('images/flutter-logo.png'),
          onPressed: () {},
        ),
      ],
    );
  }
}
