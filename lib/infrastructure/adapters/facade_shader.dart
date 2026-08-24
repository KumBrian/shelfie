import 'package:three_js/three_js.dart' as three;

class FacadeShader {
  static three.ShaderMaterial createMaterial(double buildingId) {
    final material = three.ShaderMaterial();
    material.uniforms = {
      'time': three.Uniform(0.0),
      'buildingId': three.Uniform(buildingId),
    };
    material.vertexShader = '''
        varying vec2 vUv;
        void main() {
          vUv = uv;
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
      ''';
    material.fragmentShader = '''
        uniform float time;
        uniform float buildingId;
        varying vec2 vUv;

        float random(vec2 st) {
          return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
        }

        void main() {
          vec2 grid = fract(vUv * vec2(10.0, 5.0)); // Grid of windows
          vec2 id = floor(vUv * vec2(10.0, 5.0));

          float state = random(id + buildingId);

          vec3 color = vec3(0.05, 0.05, 0.1); // Dark building color

          if (state > 0.6 && grid.x > 0.2 && grid.x < 0.8 && grid.y > 0.2 && grid.y < 0.8) {
            // Window is "on"
            color = vec3(0.0, 1.0, 1.0) * (1.0 + sin(time + buildingId) * 0.2); // Glowing Cyan
            color *= 2.0; // Emissive boost
          }

          gl_FragColor = vec4(color, 1.0);
        }
      ''';
    return material;
  }
}
