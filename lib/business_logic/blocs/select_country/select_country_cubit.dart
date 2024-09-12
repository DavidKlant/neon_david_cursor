// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:neon_david_cursor/data/country_data.dart';

part 'select_country_state.dart';

class SelectCountryCubit extends Cubit<SelectCountryCubitState> {
  SelectCountryCubit()
      : super(SelectCountryCubitState(
          countryCode: CountryData.allCountryCode,
          countryName: "All",
        ));

  void selectCountry(String emoji) {
    emit(SelectCountryCubitState(
      countryCode: CountryData.emojiToCountryCodeAndName[emoji]?.countryCode ??
          CountryData.allCountryCode,
      countryName:
          CountryData.emojiToCountryCodeAndName[emoji]?.countryName ?? "All",
    ));
  }
}
