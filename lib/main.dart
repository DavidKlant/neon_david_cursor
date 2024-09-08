import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Age Predictor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => NameAgeBloc(),
        child: const HomePage(),
      ),
    );
  }
}

// Events
abstract class NameAgeEvent {}

class SubmitNameEvent extends NameAgeEvent {
  final String name;
  SubmitNameEvent(this.name);
}

class ResetEvent extends NameAgeEvent {}

// States
abstract class NameAgeState {}

class InitialState extends NameAgeState {}

class LoadingState extends NameAgeState {}

class ResultState extends NameAgeState {
  final String result;
  ResultState(this.result);
}

// Bloc
class NameAgeBloc extends Bloc<NameAgeEvent, NameAgeState> {
  NameAgeBloc() : super(InitialState()) {
    on<SubmitNameEvent>((event, emit) async {
      emit(LoadingState());
      String result = await predictAge(event.name);
      emit(ResultState(result));
    });
    on<ResetEvent>((event, emit) {
      emit(InitialState());
    });
  }

  Future<String> predictAge(String name) async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final age = data['age'];
      return "People named $name are $age years old on average.";
    } else {
      throw Exception('Failed to predict age');
    }
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name Age Predictor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NameInputForm(),
            const SizedBox(height: 20),
            BlocBuilder<NameAgeBloc, NameAgeState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is ResultState) {
                  return Column(
                    children: [
                      Text(
                        state.result,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<NameAgeBloc>().add(ResetEvent());
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NameInputForm extends StatefulWidget {
  @override
  _NameInputFormState createState() => _NameInputFormState();
}

class _NameInputFormState extends State<NameInputForm> {
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
            decoration: InputDecoration(
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
