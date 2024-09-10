import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/blocs/name_age_bloc/name_age_bloc_bloc.dart';

class NameInputForm extends StatefulWidget {
  const NameInputForm({super.key});

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
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter a name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final name = _controller.text.trim();
              if (name.isNotEmpty) {
                context.read<NameAgeBloc>().add(SubmitNameEvent(name));
              }
            },
            child: const Text('Send'),
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
