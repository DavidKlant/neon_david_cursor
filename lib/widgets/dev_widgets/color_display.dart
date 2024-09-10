import 'package:flutter/material.dart';

class ColorDisplay extends StatelessWidget {
  const ColorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    List<Color> colors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
      colorScheme.error,
      colorScheme.surface,
      colorScheme.onSurface,
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.tertiaryContainer,
      colorScheme.errorContainer,
      colorScheme.outline,
      colorScheme.outlineVariant,
      colorScheme.scrim,
      colorScheme.inversePrimary,
      colorScheme.inverseSurface,
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors
          .map((color) => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ))
          .toList(),
    );
  }
}
