import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/drawer/Drawer_Item.dart';
import 'package:myapp/pages/About.dart';
import 'package:myapp/utils/Hex_Color.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: HexColor('#121212'),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
        child: Column(
          children: [
            headerWIdget(),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              thickness: 1,
              height: 10,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 40,
            ),
            DrawerItem(
              icon: Icons.person,
              name: 'About Us',
              onPressed: () => onItemPressed(context, index: 0),
            ),
          ],
        ),
      ),
    ));
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const About()));
    }
  }

  Widget headerWIdget() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preference',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.white,
                  letterSpacing: 1,
                )),
          ],
        )
      ],
    );
  }
}
