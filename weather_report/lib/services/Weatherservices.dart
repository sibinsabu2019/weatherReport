// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'dart:convert';

// import 'package:weather_report/Model/weatherModel.dart';
// import 'package:weather_report/provider/userprovider/UserProvider.dart';

// class WeatherService {
//   Future<void> fetchWeather(String country, String state, String district, String city,BuildContext context) async {
//    Map<String,dynamic>data={};

//     final response = await http.get(Uri.parse('http://api.weatherapi.com/v1/forecast.json?key=d7790e8c1be944229a8170753240808&q=$city&days=1&aqi=no&alerts=no'));
//     // var response = await http.get(Uri.parse(apiUrl));
//       log(response.statusCode.toString());
//     if (response.statusCode == 200) {

//       var data = jsonDecode(response.body);
//       data=jsonDecode(response.body);
//       weather Weather=weather.fromJson(data);
//       Provider.of<Userprovider>(context,listen: false).weatherSnd(Weather);
//       // log(Weather.tempC.toString());

//       // log(data.toString());
//     } else {
//       log("sucess");
//       print('Failed to fetch weather data');
//     }
//   }
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:weather_report/Model/weatherModel.dart';
import 'package:weather_report/provider/userprovider/UserProvider.dart';

class WeatherService {
  Future<void> fetchWeather(String country, String state, String district,
      String city, BuildContext context) async {
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=d7790e8c1be944229a8170753240808&q=$city&days=1&aqi=no&alerts=no'));

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Weather weatherData = Weather.fromJson(data);

      List<HourlyWeather> selectedHours =
          weatherData.hourlyWeather!.take(4).toList();

      for (var hour in selectedHours) {
        log('Time: ${hour.time}, Temp: ${hour.tempC}°C');
      }

      Provider.of<Userprovider>(context, listen: false).weatherSnd(weatherData);
    } else {
      log("Failed to fetch weather data");
    }
  }
}
