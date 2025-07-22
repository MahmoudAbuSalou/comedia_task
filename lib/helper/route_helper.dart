import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Using GetX for navigation

import '../features/weather/presentation/screens/weather_screen.dart'; // Adjust this import path as needed

class RouteHelper {
  static const String initial = '/weather';

  // No static GoRouter instance or setRouter method needed for GetX

  // Only the initial route is exposed
  static String getInitialRoute({bool fromSplash = false}) => initial;

  // The routes list now uses GetPage for GetX
  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => getRoute( WeatherScreen()),
    ),
  ];

  // Simplified getRoute function
  static Widget getRoute(Widget navigateTo) {
    // In this simplified version, we just return the widget directly.
    return navigateTo;
  }


  static void goWeatherScreenAndReplaceAll() {
    Get.offAllNamed(initial);
  }

  static void pushWeatherScreen() {
    Get.toNamed(initial);
  }
}
