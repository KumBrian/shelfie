import 'package:vector_math/vector_math_64.dart';
import 'building_entity.dart';

class WorldState {
  Vector3 cameraPosition;
  Quaternion cameraRotation;
  List<BuildingEntity> buildings;

  WorldState({
    required this.cameraPosition,
    required this.cameraRotation,
    required this.buildings,
  });
}
