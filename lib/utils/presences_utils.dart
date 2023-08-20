import 'dart:math';


double limitDecimalPlaces(double number, {int limit = 5}) {
  final divisor = pow(10, limit);
  double result = (number * divisor).round() / divisor;
  return result;
}




double haversine(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371000; // Jari-jari bumi dalam meter

  double deltaLat = _toRadians(lat2 - lat1);
  double deltaLon = _toRadians(lon2 - lon1);

  double a = pow(sin(deltaLat / 2), 2) +
      cos(_toRadians(lat1)) *
          cos(_toRadians(lat2)) *
          pow(sin(deltaLon / 2), 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = R * c;
  return distance;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}

