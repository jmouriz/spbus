class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinate.fromJson(List<dynamic> json) {
    return Coordinate(
      latitude: json[0],
      longitude: json[1],
    );
  }
}

class Route {
  final String name;
  final String color;
  final List<Coordinate> route;

  Route({
    required this.name,
    required this.color,
    required this.route,
  });

  Coordinate coordinate(index) {
    return route[index];
  }

  int count() {
    return route.length;
  }

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      name: json['name'],
      color: json['color'],
      route: [
        for (final coordinate in json['data']) 
          Coordinate.fromJson(coordinate as List<dynamic>)
      ],
    );
  }
}

class Routes {
  final List<Route> _routes;

  Routes({
    required routes,
  }) : _routes = routes;

  Route route(index) {
    return _routes[index];
  }

  int count() {
    return _routes.length;
  }

  String name(index) {
    return _routes[index].name;
  }

  factory Routes.fromJson(List<dynamic> json) {
    return Routes(
      routes: [
        for (final route in json) 
          Route.fromJson(route as Map<String, dynamic>),
      ],
    );
  }
}