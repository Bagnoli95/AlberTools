import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/const_paleta.dart';

class MyScaffold extends StatelessWidget {
  final Widget myBody;

  const MyScaffold({super.key, required this.myBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColorTertiary,
        title: IntrinsicHeight(
          child: Row(
            children: [
              // Icon(Icons.monetization_on_outlined),
              // VerticalDivider(
              //   color: Colors.white,
              //   thickness: 2,
              //   width: 25,
              // ),
              Text(
                'AlberTools',
                // style: GoogleFonts.yatraOne(fontSize: 25),
                style: GoogleFonts.caveat(fontSize: 35),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: myColorPrimary,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: myColorTertiary,
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   // backgroundColor: Colors.green,
      //   child: const Icon(
      //     Icons.monetization_on_outlined,
      //     size: 40,
      //   ),
      // ),
      // body: PresupuestoPasos(), //Para el efecto swipe
      body: myBody,
    );
  }
}
