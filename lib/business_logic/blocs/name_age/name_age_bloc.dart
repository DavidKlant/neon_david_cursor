import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:neon_david_cursor/data/country_data.dart';

part 'name_age_event.dart';
part 'name_age_state.dart';

class NameAgeBloc extends Bloc<NameAgeEvent, NameAgeState> {
  NameAgeBloc() : super(InitialState()) {
    on<SubmitNameEvent>((event, emit) async {
      emit(LoadingState());
      String result =
          await predictAge(event.name, event.countryCode, event.countryName);
      emit(ResultState(result));
    });
    on<ResetEvent>((event, emit) {
      emit(InitialState());
    });
  }

  Future<String> predictAge(
      String name, String countryCode, String countryName) async {
    // set country code for url. This is an empty string if ALL(worldwide) is selected.
    final countryCodeString = countryCode == CountryData.allCountryCode
        ? ''
        : "&country_id=$countryCode";
    try {
      final response = await http
          .get(Uri.parse('https://api.agify.io/?name=$name$countryCodeString'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int? age = data['age'];
        if (age != null) {
          // add text telling user the country they selected. This is an empty string if ALL(worldwide) is selected.
          String inCountryString = countryCode == CountryData.allCountryCode
              ? ''
              : " in <b>$countryName</b>";
          return "<b>$name</b>$inCountryString is <b>$age</b> years old.";
        } else {
          // if API returns null, tell user this name can not be predicted.
          return "Failed to predict age for the name <b>$name</b>.";
        }
      } else {
        return 'Failed to predict age.';
      }
    } catch (e) {
      if (e is TimeoutException || e is SocketException) {
        return 'Failed to predict age. Please check your internet connection.';
      } else {
        return 'Failed to predict age.';
      }
    }
  }
}
