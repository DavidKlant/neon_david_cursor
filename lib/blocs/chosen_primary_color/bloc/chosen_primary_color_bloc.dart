import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chosen_primary_color_event.dart';
part 'chosen_primary_color_state.dart';

class ChosenPrimaryColorBloc
    extends Bloc<ChooseColor, ChosenPrimaryColorState> {
  ChosenPrimaryColorBloc()
      : super(const ChosenPrimaryColorState(color: Colors.blueAccent)) {
    on<ChooseColor>((event, emit) {
      emit(ChosenPrimaryColorState(color: event.color));
    });
  }
}
