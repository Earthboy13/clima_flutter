import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      //home: LoadingScreen(),
      initialRoute: '/loading',
      routes: {
        '/loading': (BuildContext context) {
          return LoadingScreen();
        },
        '/location': (BuildContext context) {
          return LocationScreen();
        },
        '/city': (BuildContext context) {
          return CityScreen();
        },
      },
    );
  }
}
