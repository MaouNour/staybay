import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staybay/cubits/locale/locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
    : super(
        LocaleState(
          currentLanguage: 'EN',
          localizedStrings: {},
          textDirection: TextDirection.ltr,
        ),
      ) {
    _loadLocalizedStrings();
  }
  // Public initializer
  Future<void> init() async {
    await _loadLocalizedStrings();
  }
  // New method this is for the first method remove if you want this
  // Future<void> loadInitial() async {
  //   await _loadLocalizedStrings();
  // }

  Future<void> _loadLocalizedStrings() async {
    String jsonString = await rootBundle.loadString(
      'assets/locales/${state.currentLanguage}.json',
    );
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    emit(
      state.copyWith(
        localizedStrings: jsonMap,
        textDirection: state.currentLanguage == 'AR'
            ? TextDirection.rtl
            : TextDirection.ltr,
      ),
    );
  }

  void changeLanguage(String languageCode) {
    emit(state.copyWith(currentLanguage: languageCode));
    _loadLocalizedStrings();
  }
}
