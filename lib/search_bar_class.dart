import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarClass extends StatelessWidget {
  const SearchBarClass({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 50,
      child: SearchBar(
        elevation: WidgetStatePropertyAll(0),
        hintText: 'Durchsuchen',
        hintStyle: WidgetStateProperty.all(
          GoogleFonts.poppins(
            fontSize: 20,
            color: const Color.fromARGB(255, 2, 76, 9),
          ),
        ),
        leading: const Icon(
          Icons.search,
          color: const Color.fromARGB(255, 2, 76, 9),
        ),
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(119, 252, 251, 251),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
        ),
      ),
    );
  }
}
