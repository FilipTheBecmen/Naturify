import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:naturify/find_location_button.dart';
import 'package:naturify/hamburger_menu.dart';
import 'package:naturify/search_bar_class.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

import 'dart:async';
import 'package:geolocator/geolocator.dart';

class OpenStreetMapScreen extends StatefulWidget {
  const OpenStreetMapScreen({super.key});

  @override
  State<OpenStreetMapScreen> createState() {
    return _OpenStreetMap();
  }
}

class _OpenStreetMap extends State<OpenStreetMapScreen>
    with TickerProviderStateMixin {
  //
  late final _animatedMapController;

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(microseconds: 500),
      curve: Curves.easeInOut,
      cancelPreviousAnimations: true,
    );
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  Position? currentPosition;
  double _currentZoomValue = 10.0;

  // final MapController _mapController = MapController(); // for moving and

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(
            initialCenter: LatLng(47.0707, 15.4395), // Open in Graz
            initialZoom: _currentZoomValue,
          ),
          children: [
            TileLayer(
              // Bring your own tiles
              retinaMode: RetinaMode.isHighDensity(context),
              urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
              userAgentPackageName: 'com.naturify.app',
              // Add your app identifier
              tileProvider: NetworkTileProvider(
                cachingProvider: BuiltInMapCachingProvider.getOrCreateInstance(
                  maxCacheSize: 1_000_000_000, // 1 GB is the default),
                  // And many more recommended properties!
                ),
              ),
            ),
            CurrentLocationLayer(
              style: const LocationMarkerStyle(
                marker: DefaultLocationMarker(
                  color: Color.fromARGB(255, 9, 166, 15),
                  // child: Icon(
                  //   Icons.location_on_outlined,
                  //   color: Color.fromARGB(255, 255, 255, 255),
                  // ),
                ),
                markerSize: Size(35, 35),
                markerDirection: MarkerDirection.heading,
              ),
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(30, 40),
                  width: 80,
                  height: 80,
                  child: FlutterLogo(),
                ),
              ],
            ),
            RichAttributionWidget(
              // Include a stylish prebuilt attribution widget that meets all requirments
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                    Uri.parse('https://openstreetmap.org/copyright'),
                  ), // (external)
                ),
                // Also add images...
              ],
            ),
          ],
        ),

        Positioned(
          top: 30,
          right: 15,
          child: RawMaterialButton(
            onPressed: _determinePosition,

            fillColor: const Color.fromARGB(255, 0, 191, 99),
            constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            child: const Icon(Icons.my_location, color: Colors.white),
          ),
        ),

        Positioned(
          bottom: 120,
          right: 15,
          child: Column(
            children: [
              RawMaterialButton(
                onPressed: zoomIn,

                fillColor: const Color.fromARGB(255, 0, 191, 99),
                constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              SizedBox(height: 5),
              RawMaterialButton(
                onPressed: zoomOut,

                fillColor: const Color.fromARGB(255, 0, 191, 99),
                constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Text(
                  '-',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],

      // Align(
      //   alignment: Alignment.bottomRight,
      //   child: Padding(
      //     padding: EdgeInsetsGeometry.only(top: 35, right: 15),
      //     child: Column(
      //       children: [
      //         ElevatedButton(onPressed: () {}, child: Icon(Icons.plus_one)),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  void zoomIn() {
    setState(() {
      print('Zoom in');
      _currentZoomValue = _currentZoomValue + 0.4;

      // _mapController.move(
      //   _mapController.camera.center,
      //   _currentZoomValue + 0.4,
      // );
      _animatedMapController.animateTo(
        dest: _animatedMapController.mapController.camera.center,
        zoom: _currentZoomValue,
      );
    });
  }

  void zoomOut() {
    setState(() {
      print('Zoom out');
      _currentZoomValue = _currentZoomValue - 0.4;

      // _mapController.move(
      //   _mapController.camera.center,
      //   _currentZoomValue - 0.4,
      // );

      _animatedMapController.animateTo(
        dest: _animatedMapController.mapController.camera.center,
        zoom: _currentZoomValue,
      );
    });
  }

  void _determinePosition() async {
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
    setState(() {
      currentPosition = position;
      _currentZoomValue = 15.0;

      // _mapController.move(
      //   LatLng(position.latitude, position.longitude),
      //   _currentZoomValue,
      // );
      _animatedMapController.animateTo(
        dest: LatLng(position.latitude, position.longitude),
        zoom: _currentZoomValue,
      );
    });
  }

  void getLastKnownPosition() async {
    Position? position = await Geolocator.getLastKnownPosition();
  }

  // void calculateDistance() {
  //   double distanceInMeters = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude)
  // }
}
