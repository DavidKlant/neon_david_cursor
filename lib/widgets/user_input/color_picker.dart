import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/business_logic/blocs/chosen_primary_color/bloc/chosen_primary_color_bloc.dart';
import 'package:neon_david_cursor/data/color_data.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ChosenPrimaryColorBloc, ChosenPrimaryColorState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.transparent, width: 0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Color>(
                value: ColorData.colors.contains(state.color)
                    ? state.color
                    : ColorData.defaultColor,
                onChanged: (Color? newValue) {
                  if (newValue != null) {
                    context
                        .read<ChosenPrimaryColorBloc>()
                        .add(ChooseColor(color: newValue));
                  }
                },
                icon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
                style: TextStyle(color: colorScheme.onSurface),
                dropdownColor: colorScheme.onPrimary,
                items: ColorData.colors.map((Color color) {
                  return DropdownMenuItem<Color>(
                    value: color,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
