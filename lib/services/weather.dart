import 'package:clima/secrets/keys.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  static Locator finder;
  static String getWeatherIcon(int condition, bool isDay) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return isDay ? 'โ๏ธ' : '๐';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp > 10) {
      return 'Bring a ๐งฅ just in case';
    } else {
      return 'You\'ll need ๐งฃ and ๐งค';
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
