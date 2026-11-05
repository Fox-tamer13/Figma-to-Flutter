import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/attraction.dart';

class AttractionRepository {
  static const String _path = 'assets/data/attractions.json';

  Future<List<Attraction>> loadAttractions() async {
    final String text = await rootBundle.loadString(_path);

    final List<dynamic> items = jsonDecode(text);
    return items
        .map((item) => Attraction.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}