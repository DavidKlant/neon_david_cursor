import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/models/country_data.dart';
import '../blocs/select_country_cubit/select_country_cubit.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({super.key});

  @override
  Widget build(BuildContext context) {
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
                icon: Icon(Icons.arrow_drop_down, color: Colors.blue.shade400),
                style: TextStyle(color: Colors.blue.shade900),
                dropdownColor: Colors.white,
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
                            style: TextStyle(
                                color: Colors.blue.shade700)), // Country code
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
