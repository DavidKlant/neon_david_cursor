import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:neon_david_cursor/other_business_logic/shared_prefs.dart';

part 'chosen_primary_color_event.dart';
part 'chosen_primary_color_state.dart';

class ChosenPrimaryColorBloc
    extends Bloc<ChooseColor, ChosenPrimaryColorState> {
  ChosenPrimaryColorBloc()
      : super(ChosenPrimaryColorState(color: SharedPrefs.getColor())) {
    on<ChooseColor>((event, emit) {
      SharedPrefs.saveColor(event.color);
      emit(ChosenPrimaryColorState(color: event.color));
    });
  }
}
