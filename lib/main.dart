import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_david_cursor/blocs/name_age/name_age_bloc.dart';
import 'package:neon_david_cursor/blocs/select_country/select_country_cubit.dart';
import 'package:neon_david_cursor/blocs/chosen_primary_color/bloc/chosen_primary_color_bloc.dart';
import 'package:neon_david_cursor/other_business_logic/shared_prefs.dart';
import 'package:neon_david_cursor/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NameAgeBloc()),
        BlocProvider(create: (context) => SelectCountryCubit()),
        BlocProvider(create: (context) => ChosenPrimaryColorBloc()),
      ],
      child: BlocBuilder<ChosenPrimaryColorBloc, ChosenPrimaryColorState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Name Age Predictor',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: state.color,
                primary: state.color,
              ),
              useMaterial3: true,
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
