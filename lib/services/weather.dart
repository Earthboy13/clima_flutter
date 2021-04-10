import 'package:clima/secrets/keys.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  static Locator finder;
  static String getWeatherIcon(int condition, bool isDay) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return isDay ? '☀️' : '🌙';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp > 10) {
      return 'Bring a 🧥 just in case';
    } else {
      return 'You\'ll need 🧣 and 🧤';
    }
  }

  static Future<dynamic> getLocationWeatherData() async {
    finder = Locator();
    await finder.getCurrentLocation();
    NetworkMangaer httpCaller = NetworkMangaer();

    String url = '$openWeatherURL?lat=${finder.latitude}&lon=${finder.longitude}&appid=$apiKey&units=metric';

    if (finder.latitude != null) return httpCaller.getData(url: url);
  }

  static Future<dynamic> getCityWeatherData(int id) async {
    finder = Locator();
    await finder.getCurrentLocation();
    NetworkMangaer httpCaller = NetworkMangaer();

    String url = '$openWeatherURL?id=$id&appid=$apiKey&units=metric';

    return httpCaller.getData(url: url);
  }
}
