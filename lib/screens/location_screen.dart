import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
// import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String weather;
  int condition;
  String cityName;
  var temperature;
  bool isDay;
  String weatherMessage;
  var weatherdata;
  Map inputData;
  Map cityData = {'isSent': false};

  @override
  void initState() {
    super.initState();
  }

  _nav(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/city');
    cityData = result;
    setState(() {});
    print(result);
  }

  updateUI(dynamic weatherData) {
    if (weatherData != null) {
      weather = weatherData['weather'][0]['main'];
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      temperature = weatherData['main']['temp'];
      int sunset = weatherData['sys']['sunset']; //timezone off set from utc in seconds
      int sunrise = weatherData['sys']['sunrise']; //timezone off set from utc in seconds
      var utc = DateTime.now().toUtc();
      var sunUp = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000, isUtc: true);
      var sunDown = DateTime.fromMillisecondsSinceEpoch(sunset * 1000, isUtc: true);
      isDay = utc.isAfter(sunUp) && utc.isBefore(sunDown);

      weatherMessage = "${WeatherModel.getMessage(temperature.round())} in $cityName!";
    } else {
      weather = '';
      condition = 999;
      cityName = '';
      temperature = 0;
      weatherMessage = 'Please make sure location services are on.';
    }
  }

  @override
  Widget build(BuildContext context) {
    inputData = ModalRoute.of(context).settings.arguments;
    if (inputData['isSent']) {
      inputData['isSent'] = false;
      print('hello');
      weatherdata = inputData['data'];
    }
    if (cityData['isSent']) {
      cityData['isSent'] = false;
      print('bye');
      weatherdata = cityData['data'];
    }
    updateUI(weatherdata);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      weatherdata = await WeatherModel.getLocationWeatherData();
                      setState(() {});
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _nav(context);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${temperature.round()}°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          WeatherModel.getWeatherIcon(condition, isDay),
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherMessage,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
