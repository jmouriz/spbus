// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:spbus/models/locations.dart';

Future<Locations> fetchLocations() async {
  final uri = Uri(
    scheme: 'https',
    host: 'tecnologica.com.ar', // ZeroSSL
    path: '/position.php',
  );

  try {
    final response = await http.get(uri); // Uri.parse('...')

    if (response.statusCode == 200) {
      return Locations.fromJson(jsonDecode(response.body));
    } else {
      //throw Exception('Failed to load locations');
      debugPrint('Failed to load locations');
      return const Locations(locations: <Location>[]);
    }
  }
  catch (exception) {
    return const Locations(locations: <Location>[]);
  }
}