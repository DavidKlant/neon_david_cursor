part of 'chosen_primary_color_bloc.dart';

@immutable
sealed class ChosenPrimaryColorEvent {}

class ChooseColor extends ChosenPrimaryColorEvent {
  final Color color;

  ChooseColor({required this.color});
}
