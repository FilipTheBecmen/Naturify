import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naturify/widgets/open_street_map_screen.dart';
import 'package:naturify/screens/overview_page.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key, required this.onPressLocated});

  final void Function() onPressLocated;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 65, 136, 102),
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        children: [
          Expanded(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 180,
                  child: const DrawerHeader(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 65, 136, 102),
                    ),
                    child: Image(
                      image: AssetImage("assets/images/logo4.png"),
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),

                ListTile(
                  title: Text(
                    'Mein Standort',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context, true);
                    print('Touched');

                    onPressLocated();
                  },
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Naturdenkmäler',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OverviewPage(
                          pageTitle: 'Naturdenkmäler',
                          childAspectRatioVal: 1.5,
                          columns: 2,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Geschützte Landschaftsteile',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OverviewPage(
                          pageTitle: 'Geschützte Landschaftsteile',
                          childAspectRatioVal: 3.6,
                          columns: 1,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Statistik',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Spracheinstellung',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Über die App',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                SizedBox(height: 300),
                ListTile(
                  title: Center(
                    child: Text(
                      'Version: 0.0',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        // fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(195, 255, 255, 255),
                      ),
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
