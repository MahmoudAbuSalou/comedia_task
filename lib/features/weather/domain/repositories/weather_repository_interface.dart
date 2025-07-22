import 'package:get/get_connect/http/src/response/response.dart';


import '../../../../interfaces/repository_interface.dart';
import '../models/weather_model.dart';

abstract class WeatherRepositoryInterface extends RepositoryInterface{

  Future<WeatherResponse> fetchWeather(Map<String, dynamic> query);


}