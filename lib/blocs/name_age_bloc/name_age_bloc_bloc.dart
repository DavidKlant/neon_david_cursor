import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:neon_david_cursor/blocs/select_country_cubit/select_country_cubit.dart';
import 'package:neon_david_cursor/models/country_data.dart';

part 'name_age_bloc_event.dart';
part 'name_age_bloc_state.dart';

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
    final countryCodeString = countryCode == CountryData.allCountryCode
        ? ''
        : "&country_id=$countryCode";
    final response = await http
        .get(Uri.parse('https://api.agify.io/?name=$name$countryCodeString'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int? age = data['age'];
      if (age != null) {
        String inCountryString =
            countryCode == CountryData.allCountryCode ? '' : " in $countryName";
        return "People named $name$inCountryString are $age years old on average.";
      } else {
        return "Failed to predict age for the name $name.";
      }
    } else {
      throw Exception('Failed to predict age.');
    }
  }
}
