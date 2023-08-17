import 'package:flutter/material.dart';

import '../data/const_paleta.dart';

class MySubmitButton extends StatelessWidget {
  final Function()? onPress;
  final String buttonLabel;

  const MySubmitButton({Key? key, required this.onPress, required this.buttonLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: myColorTertiary, //background color of button
              elevation: 3, //elevation of button
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(20) //content padding inside button
              ),
          onPressed: onPress,
          child: Center(
            child: Text(
              buttonLabel,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )),
    );
  }
}
