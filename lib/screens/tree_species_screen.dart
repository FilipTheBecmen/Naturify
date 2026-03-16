import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naturify/data/natural_monument_data.dart';
import 'package:naturify/widgets/menu_card.dart';
import 'package:naturify/data/menu_colors.dart';

class TreeSpeciesScreen extends StatefulWidget {
  const TreeSpeciesScreen({super.key});

  @override
  State<TreeSpeciesScreen> createState() {
    // TODO: implement createState
    return _TreeSpeciesScreen();
  }
}

class _TreeSpeciesScreen extends State<TreeSpeciesScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 136, 101),
        title: Text(
          'Ausgewählte Baumart',
          style: GoogleFonts.poppins(
            fontSize: 24,
            // fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 65, 136, 101),
    );
  }
}
