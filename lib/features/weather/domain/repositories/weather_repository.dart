
import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository_interface.dart';

import '../../../../api/api_client.dart';
import '../../../../util/app_constants.dart';
import '../models/weather_model.dart';


class WeatherRepository implements WeatherRepositoryInterface{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  WeatherRepository({ required this.sharedPreferences, required this.apiClient});




  @override
  Future<WeatherResponse> fetchWeather(Map<String, dynamic> query) async {
    final response = await apiClient.getData(
      AppConstants.getWeather,
      query: query,
      handleError: false,
    );

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String? id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    // TODO: implement update
    throw UnimplementedError();
  }


}