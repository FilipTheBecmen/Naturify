import 'package:flutter/material.dart';

class FindLocationButton extends StatelessWidget {
  const FindLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsetsGeometry.only(top: 35, right: 15),
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 191, 99),
          foregroundColor: Colors.white,
          onPressed: () {},
          child: Icon(Icons.my_location),
        ),
      ),
    );
  }
}
