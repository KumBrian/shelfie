import 'package:vector_math/vector_math_64.dart';
import '../../domain/entities/building_entity.dart';

class DataAdapter {
  /// Mock fetching building footprints around a given GPS origin.
  Future<List<BuildingEntity>> fetchBuildings(double lat, double lon) async {
    // In a real implementation, this would call Mapbox Vector Tiles API
    return [
      BuildingEntity(
        id: 'b1',
        footprint: [
          Vector2(-10, -10),
          Vector2(10, -10),
          Vector2(10, 10),
          Vector2(-10, 10),
        ],
        height: 20,
      ),
      BuildingEntity(
        id: 'b2',
        footprint: [
          Vector2(20, 20),
          Vector2(40, 20),
          Vector2(40, 40),
          Vector2(20, 40),
        ],
        height: 15,
      ),
      BuildingEntity(
        id: 'b3',
        footprint: [
          Vector2(-30, 10),
          Vector2(-20, 10),
          Vector2(-20, 50),
          Vector2(-30, 50),
        ],
        height: 30,
      ),
    ];
  }
}
