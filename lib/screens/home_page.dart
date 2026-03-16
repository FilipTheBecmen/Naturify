import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:naturify/find_location_button.dart';
import 'package:naturify/screens/hamburger_menu.dart';
import 'package:naturify/widgets/open_street_map_screen.dart';
import 'package:naturify/widgets/search_bar_class.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  List _items = [];
  final mapController = MapController();
  double _currentZoomValue = 10;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    _items = data["items"];
  }

  void zoomIn() {
    _currentZoomValue = _currentZoomValue + 0.4;

    mapController.move(mapController.camera.center, _currentZoomValue);
  }

  void zoomOut() {
    _currentZoomValue = _currentZoomValue - 0.4;

    mapController.move(mapController.camera.center, _currentZoomValue);
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: const SearchBarClass(),
        backgroundColor: const Color.fromARGB(255, 65, 136, 102),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 251, 252, 252),
        ),
      ),
      drawer: HamburgerMenu(onPressLocated: determinePosition),
      backgroundColor: const Color.fromARGB(255, 65, 136, 102),
      body: Center(
        child: OpenStreetMapScreen(
          mapController: mapController,
          onPressLocated: determinePosition,
          onPressZoomIn: zoomIn,
          onPressZoomOut: zoomOut,
        ),
      ),
    );
  }

  //map related Function
  void determinePosition() async {
    print('in function determinePosition!!!!!!!!!');
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // Test if location services are enabled.

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        print('Location permissions are denied');
        return;
        // your App should show an explanatory UI now.
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
        'Location permissions are permanently denied, we cannot request permissions.',
      );

      return;
    }
    Position position = await Geolocator.getCurrentPosition();

    print('Current Position $position');

    _currentZoomValue = 15.0;

    mapController.move(
      LatLng(position.latitude, position.longitude),
      _currentZoomValue,
    );
  }
}
