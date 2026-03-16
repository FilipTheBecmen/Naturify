import 'package:flutter/material.dart';
import 'package:naturify/data/menu_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naturify/screens/tree_species_screen.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({super.key, required this.cardColor, required this.name});

  final Color cardColor;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (ctx) => TreeSpeciesScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: cardColor,
        ),
        child: Align(
          child: Text(
            overflow: TextOverflow.visible,
            name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              // fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
