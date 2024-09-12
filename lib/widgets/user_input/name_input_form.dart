import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/business_logic/blocs/name_age/name_age_bloc.dart';
import 'package:neon_david_cursor/business_logic/blocs/select_country/select_country_cubit.dart';
import 'package:neon_david_cursor/widgets/animations/fade_in_from_bottom.dart';
import 'package:neon_david_cursor/widgets/user_input/country_selector.dart';
import 'package:neon_david_cursor/widgets/buttons/cta_button.dart';

class NameInputForm extends StatefulWidget {
  final int delayMs;

  const NameInputForm({super.key, this.delayMs = 0});

  @override
  State<NameInputForm> createState() => NameInputFormState();
}

class NameInputFormState extends State<NameInputForm> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocListener<NameAgeBloc, NameAgeState>(
      listener: (context, state) {
        if (state is InitialState) {
          _controller.clear();
        }
      },
      child: Column(
        children: [
          FadeInFromBottom(
            delayMs: widget.delayMs,
            child: Row(
              children: [
                const SizedBox(
                  height: 56,
                  child: CountrySelector(),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter a name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: colorScheme.tertiary, width: 1),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: colorScheme.onSurface),
                      prefixIcon:
                          Icon(Icons.person, color: colorScheme.tertiary),
                    ),
                    style: TextStyle(color: colorScheme.onSurface),
                    cursorColor: colorScheme.tertiary,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FadeInFromBottom(
              delayMs: widget.delayMs + 500,
              child: CTAButton(
                  text: 'Send',
                  icon: Icons.send,
                  onPressed: () {
                    final name = _controller.text.trim();
                    if (name.isNotEmpty) {
                      final countryCode =
                          context.read<SelectCountryCubit>().state.countryCode;
                      final countryName =
                          context.read<SelectCountryCubit>().state.countryName;
                      context
                          .read<NameAgeBloc>()
                          .add(SubmitNameEvent(name, countryCode, countryName));
                    }
                  })),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
