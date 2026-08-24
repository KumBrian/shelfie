import 'package:vector_math/vector_math_64.dart';

class BuildingEntity {
  final String id;
  final List<Vector2> footprint; // Local Cartesian coordinates
  final double height;
  final double elevation;

  BuildingEntity({
    required this.id,
    required this.footprint,
    required this.height,
    this.elevation = 0.0,
  });
}
