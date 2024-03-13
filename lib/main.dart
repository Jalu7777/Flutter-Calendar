import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'screen/home.dart';
import 'package:timezone/data/latest.dart' as tz;
void main() {
  runApp(const MyApp());
  tz.initializeTimeZones();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
          useMaterial3: true
        // primarySwatch: Colors.red,
        
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        // scaffoldBackgroundColor: const Color(0xff0a0a0a),
        scaffoldBackgroundColor: const Color(0xff171b1a),
        // primarySwatch: Colors.red,
        useMaterial3: true
        
      ),
      initial: AdaptiveThemeMode.system,
      builder:(theme, darkTheme)=> MaterialApp(
        title: 'Flutter Demo',
        
        theme: theme,
        home: const Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

