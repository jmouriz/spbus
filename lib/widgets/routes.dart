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
import 'package:spbus/themes/color.dart';
import 'package:spbus/themes/themes.dart';

import 'package:spbus/providers/routes.dart';
import 'package:spbus/models/routes.dart';

class RoutesWidget extends StatefulWidget {
  RoutesWidget({super.key});

  final _controller = Get.put(MapExtendedController());

  @override
  State<RoutesWidget> createState() => _RoutesWidgetState();
}

class _RoutesWidgetState extends State<RoutesWidget> {
  Future<Routes> _routes = fetchRoutes();
  Future<Position?> _position = determinePosition();
  late final Timer _timer;
  int _route = 0;
  bool _once = false;
  bool _popup = false;

  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    //widget._controller.setState = update;
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
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
    _routes.then((routes) {
      for (int index = 0; index < routes.route(_route).count(); index++) {
        bounds.extend(LatLng(
          routes.route(_route).coordinate(index).latitude,
          routes.route(_route).coordinate(index).longitude,
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
      future: Future.wait([_routes, _position]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final Routes routes = snapshot.data![0];
          dynamic position = snapshot.data![1];
          final double delta = distance(widget._controller.center, position);
          if (delta > 100) {
            if (!_once) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                SnackBar snackBar = SnackBar(
                  content: Text(
                      'Estás a ${delta.toStringAsFixed(2)} km de distancia de la ciudad, reemplazaremos tu ubicación real por una ubicación ficticia para que puedas usar la aplicación.'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
              _once = true;
            }
            position = widget._controller.test;
          }
          return Stack(
            children: [
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      for (int index = 0;
                        index < routes.route(_route).count();
                        index++) LatLng(
                        routes.route(_route).coordinate(index).latitude,
                        routes.route(_route).coordinate(index).longitude,
                      ),
                    ],
                    strokeWidth: 6,
                    color: color(routes.route(_route).color).withOpacity(0.75),
                  ),
                ],
              ),
              if (position != null) MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      position.latitude,
                      position.longitude,
                    ),
                    builder: (context) => const PositionIcon(),
                  )
                ],
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: ElevatedButton(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('RECORRIDOS'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(_popup ? Icons.expand_more : Icons.expand_less),
                      ),
                    ],
                  ),
                  onPressed: () {
                    _popup = !_popup;
                    update();
                  },
                ),
              ),
              if (_popup) Positioned(
                left: 32,
                bottom: 64,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 8.0,
                      bottom: 8.0,
                      right: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int index = 0;
                          index < routes.count();
                          index++) InkWell(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  _route == index
                                  ? Icons.radio_button_on
                                  : Icons.radio_button_off,
                                  color: greenTheme,
                                ),
                              ),
                              Text(routes.name(index),
                                style: const TextStyle(color: greenTheme),
                              ),
                            ],
                          ),
                          onTap: () {
                            _route = index;
                            fit();
                          }
                        ),
                      ],
                    ),
                  ),
                )
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
        return const Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(greenTheme),
          ),
        );
      },
    );
  }
}
