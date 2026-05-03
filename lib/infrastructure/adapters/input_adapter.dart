import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math_64.dart';

class InputAdapter {
  final Vector2 _joystickDelta = Vector2.zero();
  Quaternion _gyroRotation = Quaternion.identity();
  StreamSubscription? _gyroSubscription;
  DateTime? _lastGyroEvent;

  void setJoystickDelta(double x, double y) {
    _joystickDelta.setValues(x, y);
  }

  void startGyroscope() {
    _lastGyroEvent = DateTime.now();
    _gyroSubscription = gyroscopeEventStream().listen((GyroscopeEvent event) {
      final now = DateTime.now();
      final dt = now.difference(_lastGyroEvent!).inMicroseconds / 1000000.0;
      _lastGyroEvent = now;

      // Rotate around local axes
      double pitch = event.x * dt;
      double yaw = event.y * dt;
      double roll = event.z * dt;

      Quaternion deltaRotation = Quaternion.euler(pitch, yaw, roll);
      _gyroRotation = _gyroRotation * deltaRotation;
    });
  }

  void stopGyroscope() {
    _gyroSubscription?.cancel();
  }

  Vector2 get movementVector => _joystickDelta;
  Quaternion get rotation => _gyroRotation;
}
