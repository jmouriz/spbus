import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MapExtendedController extends GetxController {
  final MapController controller = MapController();
  final center = LatLng(-26.780583978500232, -60.444966586795495);
  final test = LatLng(-26.781092846086914, -60.4354476928711);
  var touched = false.obs;
  Function setState = () {};

  String _target = 'locations';

  String get target {
    return _target;
  }

  set target(String target) {
    _target = target;
    setState();
  }

  void reset() {
    touched.value = false;
    setState();
  }

  void event(MapEvent event) {
    if (event is! MapEventTap) {
      touched.value = true;
      setState();
    }
  }

  Future<void> launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not open "$url"';
    }
  }
}