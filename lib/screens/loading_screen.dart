import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  SpinKitDualRing spinkit = SpinKitDualRing(
    color: Colors.white,
    size: 50.0,
  );

  @override
  void initState() {

    getWeather();
    super.initState();
  }

 

  getWeather() {
    WeatherModel.getLocationWeatherData().then(
      (weatherData) => weatherData != null ? Navigator.pushNamed(context, '/location', arguments: {'isSent': true, 'data': weatherData}) : print('waiting'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Location'),
      ),
      body: Container(
        child: Center(
          child: spinkit,
        ),
      ),
    );
  }
}
