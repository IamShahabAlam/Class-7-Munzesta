import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'e5a3df01f4ffe9eb9f1c52b9933af374';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

      // latitude = location.latitude;
      // longitude = location.longitude;
      
      // print("***  Latitude :  ${latitude}");
      // print("*** Longitude : ${longitude}");

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition == 801) {
      return '🌩';
    } else if (condition == 802) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition == 803) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition == 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int condition) {

    if (condition == 801) {
      return 'images/1.jpg';
    } else if (condition == 802) {
      return 'images/5.jpg';
    } else if (condition < 600) {       // rain
      return 'images/7.jpg';
    } else if (condition == 803) {
      return 'images/3.jpg';
    } else if (condition < 800) {
      return 'images/6.jpg';            // haze
    } else if (condition == 800) {
      return 'images/2.jpg';
    } else if (condition == 804) {
      return 'images/4.jpg';
    } else {
      return 'images/8.jpg';
    }
  }
}
  
  
    // if (temp > 25) {
    //   return 'It\'s 🍦 time';
    // } else if (temp > 20) {
    //   return 'Time for shorts and 👕';
    // } else if (temp < 10) {
    //   return 'You\'ll need 🧣 and 🧤';
    // } else {
    //   return 'Bring a 🧥 just in case';
    // }
 
