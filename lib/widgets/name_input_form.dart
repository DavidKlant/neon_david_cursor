import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/blocs/name_age_bloc/name_age_bloc_bloc.dart';
import 'package:neon_david_cursor/blocs/select_country_cubit/select_country_cubit.dart';
import 'package:neon_david_cursor/widgets/animations/fade_in_from_bottom.dart';
import 'package:neon_david_cursor/widgets/country_selector.dart';

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
                const CountrySelector(),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter a name',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          FadeInFromBottom(
            delayMs: widget.delayMs + 500,
            child: ElevatedButton(
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
              },
              child: const Text('Send'),
            ),
          ),
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
