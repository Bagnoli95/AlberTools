import 'package:flutter/material.dart';

import '../data/const_paleta.dart';

class MySubTitle extends StatelessWidget {
  final String titleText;

  const MySubTitle({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: TextStyle(
        fontSize: 18,
        color: myColorQuaternary,
        // fontWeight: FontWeight.bold,
        // fontStyle: FontStyle.normal,
        letterSpacing: 3,
        wordSpacing: 1,
      ),
    );
  }
}
