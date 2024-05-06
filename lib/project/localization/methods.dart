import 'package:flutter/material.dart';

import 'app_localization.dart';

Locale locale(String languageCode) {
  switch (languageCode) {
    case 'en':
      return Locale('en', 'US');
    // case 'ar':
    //   return Locale('ar', "SA");
    case 'de':
      return Locale('de', "DE");
    case 'es':
      return Locale('es', 'ES');
    case 'fr':
      return Locale('fr', "FR");
    case 'hi':
      return Locale('hi', "IN");
    case 'ja':
      return Locale('ja', "JP");
    case 'ko':
      return Locale('ko', 'KR');
    case 'pt':
      return Locale('pt', "PT");
    case 'ru':
      return Locale('ru', "RU");
    case 'tr':
      return Locale('tr', "TR");
    case 'vi':
      return Locale('vi', "VN");
    case 'zh':
      return Locale('zh', "CN");
    case 'ne':
      return Locale('ne', "NP");
    default:
      return Locale('en', 'US');
  }
}

String? getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context)?.translate(key);
}

Map<String, String>? localizedMap(BuildContext context) =>
    AppLocalization.of(context)?.localizedMap();
