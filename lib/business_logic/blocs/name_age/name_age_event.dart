part of 'name_age_bloc.dart';

@immutable
sealed class NameAgeEvent {}

class SubmitNameEvent extends NameAgeEvent {
  final String name;
  final String countryCode;
  final String countryName;
  SubmitNameEvent(this.name, this.countryCode, this.countryName);
}

class ResetEvent extends NameAgeEvent {}
