import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:spbus/controllers/map.dart';
import 'package:spbus/providers/position.dart';
import 'package:spbus/icons/icons.dart';
import 'package:spbus/themes/themes.dart';

import 'package:spbus/providers/locations.dart';
import 'package:spbus/models/locations.dart';
import 'package:spbus/widgets/loader.dart';

class LocationsWidget extends StatefulWidget {
  LocationsWidget({ super.key });

  final _controller = Get.put(MapExtendedController());

  @override
  State<LocationsWidget> createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {
  Future<Locations> _locations = fetchLocations();
  Future<Position?> _position = determinePosition();
  late final Timer _timer;
  bool _once = false;

  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    //widget._controller.setState = update;
    fit();
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      _locations = fetchLocations();
      _position = determinePosition();
      if (!widget._controller.touched.value) {
        fit();
      } else {
        update();
      }
    });
  }

  void fit() {
    widget._controller.reset();
    final bounds = LatLngBounds();
    _locations.then((locations) {
      for (int index = 0; index < locations.count(); index++) {
        bounds.extend(LatLng(
          locations.location(index).latitude,
          locations.location(index).longitude,
        ));
      }
      _position.then((position) {
        final double delta = distance(widget._controller.center, position);
        if (delta > 100) {
          bounds.extend(widget._controller.test);
        } else {
          if (position != null) {
            bounds.extend(LatLng(
              position.latitude,
              position.longitude,
            ));
          }
        }
        widget._controller.controller.fitBounds(
          bounds,
          options: const FitBoundsOptions(
            padding: EdgeInsets.only(left: 15, right: 15),
          ),
        );
        update();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        _locations,
        _position
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final Locations locations = snapshot.data![0];
          dynamic position = snapshot.data![1];
          final double delta = distance(widget._controller.center, position);
          if (delta > 100) {
            if (!_once) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                SnackBar snackBar = SnackBar(
                  content: Text('Estás a ${delta.toStringAsFixed(2)} km de distancia de la ciudad, reemplazaremos tu ubicación real por una ubicación ficticia para que puedas usar la aplicación.'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
              _once = true;
            }
            position = widget._controller.test;
          }
          return Stack(
            children: [
              MarkerLayer(
                markers: [
                  for (int index = 0; index < locations.count(); index++) Marker(
                    width: 16,
                    height: 16,
                    point: LatLng(
                      locations.location(index).latitude,
                      locations.location(index).longitude,
                    ),
                    builder: (context) => const BusIcon(),
                  ),
                  if (position != null) Marker(
                    width: 16,
                    height: 16,
                    point: LatLng(
                      position.latitude,
                      position.longitude,
                    ),
                    builder: (context) => const PositionIcon(),
                  ) ],
              ),
              if (widget._controller.touched.value) Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton.small(
                  backgroundColor: Colors.white,
                  onPressed: () => fit(),
                  child: const Icon(
                    Icons.gps_fixed,
                    color: greenTheme,
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Text('Error');
        }
        return const Loader();
      },
    );
  }
}