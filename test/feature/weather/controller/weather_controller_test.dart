import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Condition;
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/presentation/controller/weather_controller.dart';



import 'package:mockito/mockito.dart';

import '../mocks/mock_weather_service.mocks.dart';

void main() {
  late WeatherController controller;
  late MockWeatherServiceInterface mockService;

  final fakeQuery = {
    'key': 'dummy-key',
    'q': '33.5138,36.2765',
    'aqi': 'yes',
  };

  final dummyWeather = WeatherResponse(
    location: Location(
      name: 'Damascus',
      region: 'Dimashq',
      country: 'Syria',
      lat: 33.5138,
      lon: 36.2765,
      tzId: 'Asia/Damascus',
      localtimeEpoch: 1234567890,
      localtime: '2025-07-21 12:00',
    ),
    current: Current(
      lastUpdatedEpoch: 1234567890,
      lastUpdated: '2025-07-21 12:00',
      tempC: 30.0,
      tempF: 86.0,
      isDay: 1,
      condition: Condition(text: 'Sunny', icon: '//icon.png', code: 1000),
      windMph: 5.0,
      windKph: 8.0,
      windDegree: 270,
      windDir: 'W',
      pressureMb: 1000,
      pressureIn: 29.5,
      precipMm: 0,
      precipIn: 0,
      humidity: 50,
      cloud: 0,
      feelslikeC: 33.0,
      feelslikeF: 91.0,
      windchillC: 29.0,
      windchillF: 84.0,
      heatindexC: 32.0,
      heatindexF: 90.0,
      dewpointC: 15.0,
      dewpointF: 59.0,
      visKm: 10,
      visMiles: 6,
      uv: 7.0,
      gustMph: 10.0,
      gustKph: 15.0,
      airQuality: AirQuality(
        co: 200.0,
        no2: 10.0,
        o3: 100.0,
        so2: 5.0,
        pm2_5: 20.0,
        pm10: 30.0,
        usEpaIndex: 2,
        gbDefraIndex: 2,
      ),
    ),
  );

  setUp(() {
    mockService = MockWeatherServiceInterface();
    controller = WeatherController(weatherServiceInterface: mockService,test: true);
    Get.put(controller); // if needed
  });

  test('should set status to loaded and store weather on success', () async {
    when(mockService.fetchWeather(fakeQuery)).thenAnswer((_) async => dummyWeather);

    await controller.fetchWeather(fakeQuery);

    expect(controller.status.value, WeatherStatus.loaded);
    expect(controller.weather, isNotNull);
    expect(controller.weather!.location.name, 'Damascus');
  });

  test('should set status to error on exception', () async {
    when(mockService.fetchWeather(fakeQuery)).thenThrow(Exception('Failed'));

    await controller.fetchWeather(fakeQuery);

    expect(controller.status.value, WeatherStatus.error);
    expect(controller.errorMessage.value, isNotEmpty);
  });


}
