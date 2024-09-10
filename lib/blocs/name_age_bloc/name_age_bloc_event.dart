part of 'name_age_bloc_bloc.dart';

@immutable
sealed class NameAgeEvent {}

class SubmitNameEvent extends NameAgeEvent {
  final String name;
  final String countryCode;
  SubmitNameEvent(this.name, this.countryCode);
}

class ResetEvent extends NameAgeEvent {}
