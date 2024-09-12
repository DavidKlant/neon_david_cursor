import 'dart:ui';

import 'package:flutter/material.dart';

class BubbleBackground extends StatelessWidget {
  final Widget child;

  const BubbleBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Positioned(
          right: -MediaQuery.of(context).size.width / 2,
          top: MediaQuery.of(context).size.width * 0.9,
          child: LayerBlurEffect(
            child: Opacity(
              opacity: 0.8,
              child: Container(
                  height: MediaQuery.of(context).size.width * 1.25,
                  width: MediaQuery.of(context).size.width * 1.25,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    shape: BoxShape.circle,
                  )),
            ),
          ),
        ),
        Positioned(
          left: -MediaQuery.of(context).size.width / 2,
          top: MediaQuery.of(context).size.width * 0.4,
          child: LayerBlurEffect(
            child: Opacity(
              opacity: 0.8,
              child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                  )),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class LayerBlurEffect extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;

  const LayerBlurEffect({
    super.key,
    required this.child,
    this.sigmaX = 100.0,
    this.sigmaY = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
