import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:naturify/find_location_button.dart';
import 'package:naturify/hamburger_menu.dart';
import 'package:naturify/search_bar_class.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:naturify/find_location_button.dart';

class OpenStreetMapScreen extends StatefulWidget {
  const OpenStreetMapScreen({super.key});

  @override
  State<OpenStreetMapScreen> createState() {
    return _OpenStreetMap();
  }
}

class _OpenStreetMap extends State<OpenStreetMapScreen> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(47.0707, 15.4395),
        initialZoom: 14,
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
        FindLocationButton(),
      ],
    );
  }
}
