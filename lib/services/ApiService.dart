import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:receipebook/models/WeatherModel.dart';

import '../main.dart';


final dio = Dio();

class ApiService {
  //if json starts from json array we should call Future<List<Weather>>
  //if json starts from json object we should call Future<Weather>
  // ApiService a = new ApiService();
  // ApiService().getWeather();
  // ApiService.getWeather();

  Future<WeatherModel> getWeather() async {
    var response = await dio.get('https://api.openweathermap.org/data/2.5/weather?lat=${pos?.latitude}&lon=${pos?.longitude}&appid=61a90cf7d11792e5026334e8977e94d2&units=Metric');
    var weather = weatherModelFromJson(response.toString());
    print("Weather ${weather.name}");
    return weather;
  }

}


