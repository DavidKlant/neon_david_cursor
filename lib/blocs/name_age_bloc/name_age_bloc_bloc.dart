import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'name_age_bloc_event.dart';
part 'name_age_bloc_state.dart';

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
