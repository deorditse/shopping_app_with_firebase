import 'package:flutter/material.dart';

///Theme Material Light__________________________________________________________________________________________________________________________________________
ThemeData _themeLight = ThemeData.light();
ThemeData themeLight = _themeLight.copyWith(
  //будут использоватьчя базовые темы и перезаписаны только те части которые нам необходимы
  appBarTheme: AppBarTheme(
    color: Colors.purple,
  ),

  textTheme: _textLight(
      _themeLight.textTheme), //_themeLight.textTheme - что будем перезаписывать
);

TextTheme _textLight(TextTheme baseTextThemeLight) {
  //также берем за основу базовую тему baseTextTheme
  return baseTextThemeLight.copyWith(
    bodyText1: baseTextThemeLight.bodyText1?.copyWith(
      color: Colors.cyan,
    ),
    bodyText2: baseTextThemeLight.bodyText2?.copyWith(
      color: Colors.greenAccent, //для дефолтного текста
    ),
  );
}

///Theme Material Dark__________________________________________________________________________________________________________________________________________
ThemeData _themeDark = ThemeData.dark();
ThemeData themeDark = _themeDark.copyWith(
  //будут использоватьчя базовые темы и перезаписаны только те части которые нам необходимы
  appBarTheme: AppBarTheme(
    color: Colors.yellow,
  ),
  textTheme: _textDart(_themeDark.textTheme),
  //_themeLight.textTheme - какую базу будем перезаписывать
);

TextTheme _textDart(TextTheme baseTextThemeDark) {
  //base - нащ базовый стиль
  return baseTextThemeDark.copyWith(
    bodyText1: baseTextThemeDark.bodyText1?.copyWith(
      color: Colors.red,
    ),
    bodyText2: baseTextThemeDark.bodyText2?.copyWith(
      color: Colors.yellow, //для дефолтного текста
    ),
  );
}
