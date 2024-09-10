part of 'name_age_bloc.dart';

// States
@immutable
sealed class NameAgeState {}

class InitialState extends NameAgeState {}

class LoadingState extends NameAgeState {}

class ResultState extends NameAgeState {
  final String result;
  ResultState(this.result);
}
