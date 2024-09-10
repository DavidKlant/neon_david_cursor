// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neon_david_cursor/business_logic/blocs/name_age/name_age_bloc.dart';
import 'package:neon_david_cursor/business_logic/blocs/select_country/select_country_cubit.dart';

import 'package:neon_david_cursor/pages/homepage.dart';

void main() {
  group('HomePage Widget Tests', () {
    testWidgets('HomePage renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<NameAgeBloc>(create: (context) => NameAgeBloc()),
              BlocProvider<SelectCountryCubit>(
                  create: (context) => SelectCountryCubit()),
            ],
            child: const HomePage(),
          ),
        ),
      );

      // Wait for animations to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify AppBar
      expect(find.text('Name Age Predictor'), findsOneWidget);

      // Verify NameInputForm is present
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Verify CountrySelector is present
      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });
  });
}
