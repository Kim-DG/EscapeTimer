
import 'dart:ui';

import 'package:flutter/material.dart';



const themeGray = Color(0xFFDFDFDF);
const themeLightGray = Color(0xFFF1F1F1);
const themeDarkGray = Color(0xFF4E4E4E);
const themeBlack = Color(0xFF2F2F2F);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: themeGray,
  primaryColor: themeLightGray,
  secondaryHeaderColor: themeDarkGray,
  fontFamily: 'Cafe',
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.black, fontSize: 20),
    bodyText1: TextStyle(color: Colors.black, fontSize: 16),
    bodyText2: TextStyle(color: themeLightGray, fontSize: 14)
  )
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: themeDarkGray,
  primaryColor: themeBlack,
  secondaryHeaderColor: themeLightGray,
  fontFamily: 'Cafe',
  textTheme: const TextTheme(
    headline1: TextStyle(color: themeLightGray, fontSize: 20),
    bodyText1: TextStyle(color: themeLightGray, fontSize: 16),
    bodyText2: TextStyle(color: Colors.black, fontSize: 14)
  )
);