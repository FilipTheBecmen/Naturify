import 'package:flutter/material.dart';

enum Type { naturalMonumentType, ProtectedAreas }

class NaturalMonument {
  const NaturalMonument({
    required this.id,
    required this.color,
    required this.treeSpecies,
    // required this.image,
    // required this.description,
    // required this.location,
  });

  final String id;
  final Color color;
  final String treeSpecies;
  // final String image;
  // final List<String> description;
  // final String location;
}
