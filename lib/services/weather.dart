import '../utilities/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'networking.dart';

class WeatherModel {
  String apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  String openWeatherUrl = dotenv.env['OPENWEATHER_API_URL'] ?? '';

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    // Get the location data
    await location.getLocation();

    String url =
        '$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&exclude=daily,hourly,minutely&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
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
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  void getWeatherData() {
    print('Got weather data');
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$openWeatherUrl?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();

    return weatherData;
  }
}
