import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/business_logic/blocs/select_country/select_country_cubit.dart';
import 'package:neon_david_cursor/data/country_data.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SelectCountryCubit, SelectCountryCubitState>(
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
              child: DropdownButton<String>(
                value: CountryData.emojiToCountryCodeAndName.entries
                    .firstWhere(
                        (entry) => entry.value.countryCode == state.countryCode)
                    .key,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    context.read<SelectCountryCubit>().selectCountry(newValue);
                  }
                },
                style: TextStyle(color: colorScheme.onSurface),
                dropdownColor: colorScheme.onPrimary,
                items:
                    CountryData.emojiToCountryCodeAndName.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(entry.key,
                            style: const TextStyle(fontSize: 18)), // Flag emoji
                        const SizedBox(width: 8),
                        Text(entry.value.countryCode,
                            style: TextStyle(color: colorScheme.onSurface)),
                      ],
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
