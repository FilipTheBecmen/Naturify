import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:naturify/find_location_button.dart';
import 'package:naturify/hamburger_menu.dart';
import 'package:naturify/open_street_map_screen.dart';
import 'package:naturify/search_bar_class.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:naturify/find_location_button.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: SearchBarClass(),
        backgroundColor: const Color.fromARGB(255, 0, 191, 99),
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 251, 252, 252),
        ),
      ),
      drawer: HamburgerMenu(),
      backgroundColor: const Color.fromARGB(255, 0, 191, 99),
      body: Center(child: OpenStreetMapScreen()),
    );
  }
}
