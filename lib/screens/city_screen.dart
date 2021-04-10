import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import '../assets/citylist.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  ///change to http request to backend -- for later
  Future<List<Map>> _printLatestValue() async {
    // ignore: unused_local_variable
    List<Map> citySuggetions = [];
    //int top5 = 0;
    return Future(() {
      // for (int i = 0; i < cities.length; i++) {
      //   Map city = cities[i];
      //   if (city['name'].contains(myController.text)) {
      //     top5++;
      //     citySuggetions.add(city);
      //   }
      //   if (top5 == 5) {
      //     break;
      //   }
      // }
      return citySuggetions;
    });

    //print("Second text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    //style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
                    //decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await _printLatestValue();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion['name']),
                      subtitle: Text('${suggestion['country']}'),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    WeatherModel.getCityWeatherData(suggestion['id']).then(
                      (weatherData) => weatherData != null ? Navigator.pop(context, {'isSent': true, 'data': weatherData}) : print('waiting'),
                    );
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => ProductPage(product: suggestion)
                    // ));
                  },
                ),
                // child: TextField(
                //   decoration: InputDecoration(
                //     //rt border: OutlineInputBorder(),
                //     hintText: 'Enter a search term',
                //   ),
                //   controller: myController,
                // ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
