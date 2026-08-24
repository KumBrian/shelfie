import 'package:vector_math/vector_math_64.dart';
import '../entities/building_entity.dart';

class PhysicsEngine {
  /// Simple 2D point-in-polygon check for collision detection.
  static bool isPointInPolygon(Vector2 point, List<Vector2> polygon) {
    bool isInside = false;
    int j = polygon.length - 1;
    for (int i = 0; i < polygon.length; i++) {
      if (((polygon[i].y > point.y) != (polygon[j].y > point.y)) &&
          (point.x < (polygon[j].x - polygon[i].x) * (point.y - polygon[i].y) / (polygon[j].y - polygon[i].y) + polygon[i].x)) {
        isInside = !isInside;
      }
      j = i;
    }
    return isInside;
  }

  static bool checkCollision(Vector2 position, List<BuildingEntity> buildings, {double radius = 0.5}) {
    for (var building in buildings) {
      if (isPointInPolygon(position, building.footprint)) {
        return true;
      }
    }
    return false;
  }

  static Vector3 calculateNextPosition(Vector3 currentPos, Vector3 velocity, double deltaTime, List<BuildingEntity> buildings) {
    Vector3 delta = velocity * deltaTime;
    Vector3 nextPos = currentPos + delta;

    // Check collision on XZ plane
    if (checkCollision(Vector2(nextPos.x, nextPos.z), buildings)) {
      // Try slide along X
      Vector3 nextPosX = currentPos + Vector3(delta.x, 0, 0);
      if (!checkCollision(Vector2(nextPosX.x, nextPosX.z), buildings)) {
        return nextPosX;
      }
      // Try slide along Z
      Vector3 nextPosZ = currentPos + Vector3(0, 0, delta.z);
      if (!checkCollision(Vector2(nextPosZ.x, nextPosZ.z), buildings)) {
        return nextPosZ;
      }
      return currentPos; // Full stop
    }

    return nextPos;
  }
}
