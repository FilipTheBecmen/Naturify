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
  OpenStreetMapScreen({
    super.key,
    required this.mapController,
    required this.onPressLocated,
    required this.currentZoomValue,
  });

  final MapController mapController;
  final void Function() onPressLocated;
  double currentZoomValue;

  @override
  State<OpenStreetMapScreen> createState() {
    return _OpenStreetMap();
  }
}

class _OpenStreetMap extends State<OpenStreetMapScreen>
    with TickerProviderStateMixin {
  //
  // late final _animatedMapController;

  // @override
  // void initState() {
  //   super.initState();
  //   _animatedMapController = AnimatedMapController(
  //     vsync: this,
  //     duration: const Duration(microseconds: 500),
  //     curve: Curves.easeInOut,
  //     cancelPreviousAnimations: true,
  //   );
  // }

  // @override
  // void dispose() {
  //   _animatedMapController.dispose();
  //   super.dispose();
  // }

  // final MapController _mapController = MapController(); // for moving and

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: widget.mapController,
          options: MapOptions(
            initialCenter: LatLng(47.0707, 15.4395), // Open in Graz
            initialZoom: widget.currentZoomValue,
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
            onPressed: widget.onPressLocated,

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
    );
  }

  void zoomIn() {
    print('Zoom in');
    widget.currentZoomValue = widget.currentZoomValue + 0.4;

    widget.mapController.move(
      widget.mapController.camera.center,
      widget.currentZoomValue,
    );
  }

  void zoomOut() {
    setState(() {
      print('Zoom out');
      widget.currentZoomValue = widget.currentZoomValue - 0.4;

      widget.mapController.move(
        widget.mapController.camera.center,
        widget.currentZoomValue,
      );
    });
  }
}
