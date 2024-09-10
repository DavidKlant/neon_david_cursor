import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/blocs/name_age_bloc/name_age_bloc_bloc.dart';
import 'package:neon_david_cursor/widgets/animations/fade_in_from_bottom.dart';
import 'package:neon_david_cursor/widgets/bubble_background.dart';
import 'package:neon_david_cursor/widgets/name_input_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name Age Predictor'),
      ),
      body: BubbleBackground(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<NameAgeBloc, NameAgeState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state is InitialState) const NameInputForm(),
                    if (state is InitialState) const SizedBox(height: 20),
                    if (state is LoadingState)
                      const CircularProgressIndicator()
                    else if (state is ResultState)
                      Column(
                        children: [
                          FadeInFromBottom(
                            delayMs: 0,
                            child: Text(
                              state.result,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeInFromBottom(
                            delayMs: 500,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<NameAgeBloc>().add(ResetEvent());
                              },
                              child: const Text('Try Again'),
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
