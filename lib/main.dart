import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/blocs/name_age/name_age_bloc.dart';
import 'package:neon_david_cursor/blocs/select_country/select_country_cubit.dart';
import 'package:neon_david_cursor/pages/homepage.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          primary: Colors.blueAccent,
        ),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NameAgeBloc()),
          BlocProvider(create: (context) => SelectCountryCubit()),
        ],
        child: const HomePage(),
      ),
    );
  }
}
