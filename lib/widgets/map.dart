import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:spbus/controllers/map.dart';

import 'package:spbus/widgets/locations.dart';
import 'package:spbus/widgets/routes.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _controller = Get.put(MapExtendedController());

  final int _flags = InteractiveFlag.pinchZoom
    | InteractiveFlag.doubleTapZoom
    | InteractiveFlag.drag;

  void update() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.setState = update;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _controller.controller,
      options: MapOptions(
        center: _controller.center,
        zoom: 17,
        interactiveFlags: _flags,
        onMapEvent: _controller.event,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'ar.tecnologica.spbus',
        ),
        if (_controller.target == 'locations')
          LocationsWidget()
        else
          RoutesWidget(),
      ],
    );
  }
}