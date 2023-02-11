import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils/Hex_Color.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#121212'),
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.montserrat(
              fontSize: 18, color: Colors.white, letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
    );
  }
}
