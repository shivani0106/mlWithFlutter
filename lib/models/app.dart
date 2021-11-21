import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funwithml/database/app_preferences.dart';
import 'package:funwithml/utils/common_utils.dart';
import 'package:funwithml/utils/constant.dart';

import 'country_master.dart';

class AppModel with ChangeNotifier {
  bool darkTheme = false;
  bool isLoading = true;
  String locale = AppConstants.LANGUAGE_NORWEGIAN;
  var appPreferences = new AppPreferences();
  List<CountryDetails> countryList = [];

  List<Language> lanName = [
    Language(language: 'English', languageCode: AppConstants.LANGUAGE_ENGLISH),
    Language(
        language: 'Norwegian', languageCode: AppConstants.LANGUAGE_NORWEGIAN)
  ];
  String? currentName = AppConstants.LANGUAGE_NORWEGIAN;

  void updateTheme(bool theme) {
    darkTheme = theme;
    notifyListeners();
  }

  getCountry(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/json/country.json');
    var jsonResult = json.decode(data);
    countryList = CountryMaster.fromJson(jsonResult).country!;
  }

  void changeLanguage() async {
    String? locale = await appPreferences.getLanguageCode();
    if (locale != null) {
      if (CommonUtils.isEmpty(locale)) {
        appPreferences.setLanguageCode(this.locale);
        locale = this.locale;
      }
      this.locale = locale;
      printf("MMMMMMMM" + locale);
    } else {
      printf("NNNNNNN");
      AppPreferences().setLanguageCode(AppConstants.LANGUAGE_NORWEGIAN);
      this.locale = AppConstants.LANGUAGE_NORWEGIAN;
    }

    notifyListeners();
  }
}

class App {
  Map<String, dynamic> appConfig;

  App(this.appConfig);
}

class Language {
  String? language;
  String? languageCode;

  Language({this.language, this.languageCode});
}
