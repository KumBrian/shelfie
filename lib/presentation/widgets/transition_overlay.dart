import 'dart:ui';
import 'package:flutter/material.dart';

class TransitionOverlay extends StatelessWidget {
  final bool active;
  final Widget child;

  const TransitionOverlay({super.key, required this.active, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (active)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.cyan),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
