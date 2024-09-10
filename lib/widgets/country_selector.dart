import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/select_country_cubit/select_country_cubit.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCountryCubit, SelectCountryCubitState>(
      builder: (context, state) {
        return DropdownButton<String>(
          value: SelectCountryCubit.emojiToCountryCodeAndName.entries
              .firstWhere(
                  (entry) => entry.value.countryCode == state.countryCode)
              .key,
          onChanged: (String? newValue) {
            if (newValue != null) {
              context.read<SelectCountryCubit>().selectCountry(newValue);
            }
          },
          items:
              SelectCountryCubit.emojiToCountryCodeAndName.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Text(entry.key), // Flag emoji
                  const SizedBox(width: 8),
                  Text(entry.value.countryCode), // Country code
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
