import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeInFromBottom extends StatelessWidget {
  final Widget child;
  final int delayMs, durationMs;
  final double begin;

  const FadeInFromBottom({
    required this.child,
    this.delayMs = 1000,
    this.durationMs = 750,
    this.begin = 0.5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delayMs.ms)
        .slideY(curve: Curves.ease, duration: durationMs.ms, begin: begin)
        .fadeIn();
  }
}
