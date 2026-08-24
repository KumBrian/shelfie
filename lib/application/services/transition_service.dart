import 'package:flutter/foundation.dart';

class TransitionService extends ChangeNotifier {
  double zoom = 15;
  double pitch = 0;
  bool showBlur = false;
  bool is3DActive = false;

  Future<void> animateMap(double lat, double lon, {double zoom = 20, double pitch = 60}) async {
    this.zoom = zoom;
    this.pitch = pitch;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<void> showRadialBlur() async {
    showBlur = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> crossFadeTo3D() async {
    is3DActive = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    showBlur = false;
    notifyListeners();
  }

  Future<void> initialize3D() async {
  }
}
