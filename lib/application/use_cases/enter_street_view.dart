import 'dart:async';
import '../services/transition_service.dart';

class EnterStreetView {
  final TransitionService transitionService;

  EnterStreetView(this.transitionService);

  Future<void> execute(double targetLat, double targetLon) async {
    await transitionService.animateMap(targetLat, targetLon, zoom: 20, pitch: 60);
    await transitionService.showRadialBlur();
    await transitionService.crossFadeTo3D();
    await transitionService.initialize3D();
  }
}
