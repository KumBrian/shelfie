import 'dart:math';
import 'package:vector_math/vector_math_64.dart';

class CoordinateMath {
  static const double earthRadius = 6371000; // meters

  /// Converts GPS coordinates (lat, lon) to a local Cartesian system (x, y)
  /// relative to an origin (lat, lon).
  /// 1 unit = 1 meter.
  static Vector2 gpsToLocal(double lat, double lon, double originLat, double originLon) {
    double x = (lon - originLon) * (earthRadius * cos(originLat * pi / 180.0)) * (pi / 180.0);
    double y = (lat - originLat) * earthRadius * (pi / 180.0);
    return Vector2(x, y);
  }
}
