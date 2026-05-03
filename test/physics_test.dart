import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:immersive_street/domain/logic/physics_engine.dart';
import 'package:immersive_street/domain/entities/building_entity.dart';

void main() {
  group('PhysicsEngine', () {
    test('isPointInPolygon identifies point inside rectangle', () {
      final polygon = [
        Vector2(0, 0),
        Vector2(10, 0),
        Vector2(10, 10),
        Vector2(0, 10),
      ];
      final point = Vector2(5, 5);
      expect(PhysicsEngine.isPointInPolygon(point, polygon), isTrue);
    });

    test('isPointInPolygon identifies point outside rectangle', () {
      final polygon = [
        Vector2(0, 0),
        Vector2(10, 0),
        Vector2(10, 10),
        Vector2(0, 10),
      ];
      final point = Vector2(15, 5);
      expect(PhysicsEngine.isPointInPolygon(point, polygon), isFalse);
    });

    test('calculateNextPosition handles collisions', () {
      final buildings = [
        BuildingEntity(
          id: 'b1',
          footprint: [
            Vector2(10, -10),
            Vector2(20, -10),
            Vector2(20, 10),
            Vector2(10, 10),
          ],
          height: 20,
        ),
      ];

      final currentPos = Vector3(5, 0, 0);
      final velocity = Vector3(10, 0, 0);
      final nextPos = PhysicsEngine.calculateNextPosition(currentPos, velocity, 1.0, buildings);

      expect(nextPos.x, lessThanOrEqualTo(10.0));
    });
  });
}
