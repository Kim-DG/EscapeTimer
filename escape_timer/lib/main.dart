import 'package:escape_timer/bloc/main_bloc.dart';
import 'package:escape_timer/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'main_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '방탈출 예약시간',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: ChangeNotifierProvider(
        create: (_) => MainBloc(),
        child: MainPage(),
    ),
    );
  }
}
