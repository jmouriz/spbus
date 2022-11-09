class Location {
  final int device;
  final int time;
  final double latitude;
  final double longitude;

  const Location({
    required this.device,
    required this.time,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      device: json['device'],
      time: json['time'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Locations {
  final List<Location> _locations;

  const Locations({
    required locations,
  }) : _locations = locations;

  Location location(index) {
    return _locations[index];
  }

  int count() {
    return _locations.length;
  }

  factory Locations.fromJson(List<dynamic> json) {
    return Locations(
      locations: [
        for (final location in json) 
          Location.fromJson(location as Map<String, dynamic>)
      ],
    );
  }
}