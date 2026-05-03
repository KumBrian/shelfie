import 'dart:math';
import 'dart:typed_data';
import 'package:three_js/three_js.dart' as three;
import 'package:vector_math/vector_math_64.dart' as vm;

class ParticleSystem {
  late three.Points points;
  final int count = 1000;
  final double areaSize = 100.0;
  final Random _random = Random();

  ParticleSystem() {
    final geometry = three.BufferGeometry();
    final positions = Float32List(count * 3);

    for (int i = 0; i < count; i++) {
      positions[i * 3] = (_random.nextDouble() - 0.5) * areaSize;
      positions[i * 3 + 1] = (_random.nextDouble() - 0.5) * areaSize;
      positions[i * 3 + 2] = (_random.nextDouble() - 0.5) * areaSize;
    }

    geometry.setAttribute(three.Attribute.position, three.Float32BufferAttribute.fromList(positions, 3));

    final material = three.PointsMaterial();
    material.color = three.Color(0x00ffff);
    material.size = 0.1;
    material.transparent = true;
    material.opacity = 0.6;
    material.blending = three.AdditiveBlending;

    points = three.Points(geometry, material);
  }

  void update(vm.Vector3 cameraPos) {
    final positions = points.geometry!.attributes['position'].array;

    for (int i = 0; i < count; i++) {
      double px = positions[i * 3];
      double py = positions[i * 3 + 1];
      double pz = positions[i * 3 + 2];

      // Brownian-ish drift
      positions[i * 3] += (_random.nextDouble() - 0.5) * 0.05;
      positions[i * 3 + 1] += (_random.nextDouble() - 0.5) * 0.05;
      positions[i * 3 + 2] += (_random.nextDouble() - 0.5) * 0.05;

      // Object Pooling: Recycle if too far from camera
      if ((vm.Vector3(px, py, pz) - cameraPos).length > areaSize / 2) {
        positions[i * 3] = cameraPos.x + (_random.nextDouble() - 0.5) * areaSize;
        positions[i * 3 + 1] = cameraPos.y + (_random.nextDouble() - 0.5) * areaSize;
        positions[i * 3 + 2] = cameraPos.z + (_random.nextDouble() - 0.5) * areaSize;
      }
    }

    points.geometry!.attributes['position'].needsUpdate = true;
  }
}
