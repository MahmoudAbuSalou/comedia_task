import 'package:get/get.dart';
import 'package:weather_app/features/weather/domain/services/weather_service_interface.dart';

import '../models/weather_model.dart';
import '../repositories/weather_repository_interface.dart';


class WeatherService implements WeatherServiceInterface{
  final WeatherRepositoryInterface weatherRepositoryInterface;
  WeatherService({required this.weatherRepositoryInterface});

  @override
  Future<WeatherResponse> fetchWeather(Map<String, dynamic> query) async{
    return await weatherRepositoryInterface.fetchWeather(query);


  }


}