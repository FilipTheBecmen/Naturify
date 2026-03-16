import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naturify/data/natural_monument_data.dart';
import 'package:naturify/widgets/menu_card.dart';
import 'package:naturify/data/menu_colors.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({
    super.key,
    required this.pageTitle,
    required this.childAspectRatioVal,
    required this.columns,
  });

  String pageTitle;
  double childAspectRatioVal;
  int columns;

  @override
  State<OverviewPage> createState() {
    // TODO: implement createState
    return _OverviewPage();
  }
}

class _OverviewPage extends State<OverviewPage> {
  var gridViewLenght = 0;
  @override
  Widget build(BuildContext context) {
    //check which page to build
    var ifStringLandsscape = widget.pageTitle.compareTo(
      'Geschützte Landschaftsteile',
    );
    if (ifStringLandsscape == 0) {
      gridViewLenght = protectedLandscape.length;
    } else {
      gridViewLenght = naturalMonumentsSpeciesList.length;
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 136, 101),
        title: Text(
          widget.pageTitle,
          style: GoogleFonts.poppins(
            fontSize: 24,
            // fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 65, 136, 101),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.columns, // two columns next to each other
          childAspectRatio: widget.childAspectRatioVal,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
        ),
        children: [
          for (var index = 0; index < gridViewLenght; index++)
            if (ifStringLandsscape == 0)
              MenuCard(
                cardColor: cardColors[index],
                name: protectedLandscape[index],
              )
            else
              MenuCard(
                cardColor: cardColors[index],
                name: naturalMonumentsSpeciesList[index],
              ),
        ],
      ),
    );
  }
}
