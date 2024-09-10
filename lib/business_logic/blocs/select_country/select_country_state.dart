part of 'select_country_cubit.dart';

@immutable
final class SelectCountryCubitState {
  final String countryCode;
  final String countryName;

  const SelectCountryCubitState(
      {required this.countryCode, required this.countryName});
}
