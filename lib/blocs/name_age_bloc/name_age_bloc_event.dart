part of 'name_age_bloc_bloc.dart';

@immutable
sealed class NameAgeEvent {}

class SubmitNameEvent extends NameAgeEvent {
  final String name;
  SubmitNameEvent(this.name);
}

class ResetEvent extends NameAgeEvent {}
