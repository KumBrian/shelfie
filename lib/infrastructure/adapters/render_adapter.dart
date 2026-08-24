import 'package:three_js/three_js.dart' as three;
import 'package:vector_math/vector_math_64.dart' as vm;
import '../../domain/entities/building_entity.dart';
import 'facade_shader.dart';

class RenderAdapter {
  late three.Scene scene;
  late three.PerspectiveCamera camera;
  late dynamic renderer;

  RenderAdapter() {
    scene = three.Scene();
    camera = three.PerspectiveCamera(75, 1, 0.1, 1000);
  }

  void setupEnvironment() {
    renderer.setClearColor(three.Color(0x05050a), 1.0);
    renderer.toneMapping = three.ReinhardToneMapping;
    renderer.toneMappingExposure = 2.0;
  }

  void createBuildings(List<BuildingEntity> buildings) {
    for (var building in buildings) {
      final shape = three.Shape();
      shape.moveTo(building.footprint[0].x, building.footprint[0].y);
      for (int i = 1; i < building.footprint.length; i++) {
        shape.lineTo(building.footprint[i].x, building.footprint[i].y);
      }
      shape.closePath();

      final geometry = three.ExtrudeGeometry([shape], three.ExtrudeGeometryOptions(
        depth: building.height,
        bevelEnabled: false,
      ));

      final material = FacadeShader.createMaterial(building.id.hashCode.toDouble());
      final mesh = three.Mesh(geometry, material);
      mesh.rotation.x = -1.5708;
      mesh.position.y = 0;

      scene.add(mesh);
    }
  }

  void updateCamera(vm.Vector3 position, vm.Quaternion rotation) {
    camera.position.setFrom(three.Vector3(position.x, position.y, position.z));
    camera.quaternion.setFrom(three.Quaternion(rotation.x, rotation.y, rotation.z, rotation.w));
  }

  void updateShaders(double time) {
    for (var child in scene.children) {
      if (child is three.Mesh && child.material is three.ShaderMaterial) {
        final material = child.material as three.ShaderMaterial;
        material.uniforms['time'].value = time;
      }
    }
  }
}
