import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTitle extends StatelessWidget {
  final String titleText;

  const MyTitle({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: TextStyle(
        fontSize: 23,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        // fontStyle: FontStyle.normal,
        letterSpacing: 3,
        wordSpacing: 1,
      ),
    );
  }
}


// TextStyle(
//         fontSize: 23,
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//         // fontStyle: FontStyle.normal,
//         letterSpacing: 3,
//         wordSpacing: 1,
//       ),

      // style: GoogleFonts.shadowsIntoLight(
      //   fontSize: 23,
      //   color: Colors.white,
      //   fontWeight: FontWeight.bold,
      //   letterSpacing: 3,
      //   wordSpacing: 3,
      // ),