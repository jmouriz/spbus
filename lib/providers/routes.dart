// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:spbus/models/routes.dart';

Future<Routes> fetchRoutes() async {
  final uri = Uri(
    scheme: 'https',
    host: 'tecnologica.com.ar', // ZeroSSL
    path: '/routes.php',
  );

  try {
    final response = await http.get(uri); // Uri.parse('...')

    if (response.statusCode == 200) {
      return Routes.fromJson(jsonDecode(response.body));
    } else {
      //throw Exception('Failed to load routes');
      debugPrint('Failed to load routes');
      return Routes(routes: []);
    }
  }
  catch (exception) {
    return Routes(routes: []);
  }

}