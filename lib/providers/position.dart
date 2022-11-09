import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

double _degress2radians(double degress) {
  return degress * (pi / 180);
}

double distance(LatLng from, Position? to) {
  if (to == null) {
    return 0;
  }
  const int radius = 6371; // radius of the earth in km
  final double dLat = _degress2radians(to.latitude - from.latitude);
  final double dLon = _degress2radians(to.longitude - from.longitude); 
  final a = // angle 
    sin(dLat / 2) * sin(dLat / 2) +
    cos(_degress2radians(from.latitude)) *
    cos(_degress2radians(to.latitude)) * 
    sin(dLon / 2) * sin(dLon / 2); 
  double c = 2 * atan2(sqrt(a), sqrt(1 - a)); 
  double distance = radius * c; // distance in km
  return distance;
}

Future<Position?> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    //return Future.error('Location services are disabled.');
    debugPrint('Location services are disabled.');
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    try {
      permission = await Geolocator.requestPermission();
    }
    on PermissionRequestInProgressException {
      return null;
    }
    if (permission == LocationPermission.denied) {
      //return Future.error('Location permissions are denied');
      debugPrint('Location permissions are denied');
      return null;
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    //return Future.error(
    //  'Location permissions are permanently denied, we cannot request permissions.'
    //);
    debugPrint(
      'Location permissions are permanently denied, we cannot request permissions.'
    );
    return null;
  } 

  try {
    return await Geolocator.getCurrentPosition();
  }
  catch (exception) {
    return null;
  }
}
