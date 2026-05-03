import 'package:flutter/material.dart';
import 'package:three_js/three_js.dart' as three;
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:vector_math/vector_math_64.dart' as vm;
import '../../infrastructure/adapters/render_adapter.dart';
import '../../infrastructure/adapters/input_adapter.dart';
import '../../infrastructure/adapters/data_adapter.dart';
import '../../domain/logic/particle_system.dart';
import '../../domain/logic/physics_engine.dart';
import '../../domain/entities/world_state.dart';

class ImmersiveStreetView extends StatefulWidget {
  final double initialLat;
  final double initialLon;

  const ImmersiveStreetView({super.key, required this.initialLat, required this.initialLon});

  @override
  State<ImmersiveStreetView> createState() => _ImmersiveStreetViewState();
}

class _ImmersiveStreetViewState extends State<ImmersiveStreetView> {
  late three.ThreeJS threeJs;
  final RenderAdapter renderAdapter = RenderAdapter();
  final InputAdapter inputAdapter = InputAdapter();
  final DataAdapter dataAdapter = DataAdapter();
  late ParticleSystem particleSystem;
  late WorldState worldState;

  bool initialized = false;
  double _elapsedTime = 0;

  @override
  void initState() {
    super.initState();
    threeJs = three.ThreeJS(
      onSetupComplete: () {
        setState(() {});
      },
      setup: setupScene,
    );
    inputAdapter.startGyroscope();
  }

  @override
  void dispose() {
    inputAdapter.stopGyroscope();
    threeJs.dispose();
    super.dispose();
  }

  Future<void> setupScene() async {
    renderAdapter.renderer = threeJs.renderer!;
    renderAdapter.scene = threeJs.scene;
    renderAdapter.camera = threeJs.camera as three.PerspectiveCamera;

    renderAdapter.setupEnvironment();

    particleSystem = ParticleSystem();
    renderAdapter.scene.add(particleSystem.points);

    worldState = WorldState(
      cameraPosition: vm.Vector3(0, 1.7, 0),
      cameraRotation: vm.Quaternion.identity(),
      buildings: [],
    );

    final buildings = await dataAdapter.fetchBuildings(widget.initialLat, widget.initialLon);
    setState(() {
      worldState.buildings = buildings;
    });

    renderAdapter.createBuildings(buildings);

    initialized = true;

    threeJs.addAnimationEvent((dt) {
      update(dt);
    });
  }

  void update(double dt) {
    if (!initialized) return;
    _elapsedTime += dt;

    // Movement relative to camera yaw
    vm.Vector2 move = inputAdapter.movementVector;

    // Extract yaw from camera quaternion
    // In three_js / vector_math, we can rotate a vector by a quaternion
    vm.Vector3 forward = vm.Vector3(0, 0, -1);
    vm.Vector3 right = vm.Vector3(1, 0, 0);

    vm.Quaternion rotation = inputAdapter.rotation;
    forward = rotation.rotated(forward);
    right = rotation.rotated(right);

    // Flatten to XZ plane
    forward.y = 0;
    forward.normalize();
    right.y = 0;
    right.normalize();

    vm.Vector3 velocity = (forward * (-move.y) + right * move.x) * 5.0;

    worldState.cameraPosition = PhysicsEngine.calculateNextPosition(
      worldState.cameraPosition,
      velocity,
      dt,
      worldState.buildings
    );

    worldState.cameraRotation = rotation;

    renderAdapter.updateCamera(worldState.cameraPosition, worldState.cameraRotation);
    particleSystem.update(worldState.cameraPosition);
    renderAdapter.updateShaders(_elapsedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          threeJs.build(),
          Positioned(
            left: 20,
            bottom: 40,
            child: Joystick(
              listener: (details) {
                inputAdapter.setJoystickDelta(details.x, details.y);
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
