import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/blocs/name_age_bloc/name_age_bloc_bloc.dart';
import 'package:neon_david_cursor/widgets/animations/fade_in_from_bottom.dart';
import 'package:neon_david_cursor/widgets/bubble_background.dart';
import 'package:neon_david_cursor/widgets/buttons/cta_button.dart';
import 'package:neon_david_cursor/widgets/markdown_text.dart';
import 'package:neon_david_cursor/widgets/user_input/name_input_form.dart';

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
            padding: const EdgeInsets.all(24.0),
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
                            child: MarkdownText(
                              state.result,
                              style: Theme.of(context).textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),
                          FadeInFromBottom(
                            delayMs: 500,
                            child: CTAButton(
                              onPressed: () {
                                context.read<NameAgeBloc>().add(ResetEvent());
                              },
                              text: 'Try Again',
                              icon: Icons.refresh,
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
