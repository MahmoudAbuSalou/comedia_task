import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/api_client.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../mocks/mock_dependencies.mocks.dart'; // تأكد من أن ملف mock موجود ومولد بـ build_runner

void main() {
  late WeatherRepository repository;
  late MockApiClient mockApiClient;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockApiClient = MockApiClient();
    mockPrefs = MockSharedPreferences();
    repository = WeatherRepository(
      apiClient: mockApiClient,
      sharedPreferences: mockPrefs,
    );
  });

  final query = {
    'key': 'dummy-key',
    'q': '33.5138,36.2765',
    'aqi': 'yes',
  };

  final fakeResponseJson = {
    "location": {
      "name": "Damascus",
      "region": "Dimashq",
      "country": "Syria",
      "lat": 33.5138,
      "lon": 36.2765,
      "tz_id": "Asia/Damascus",
      "localtime_epoch": 1234567890,
      "localtime": "2025-07-21 12:00"
    },
    "current": {
      "last_updated_epoch": 1234567890,
      "last_updated": "2025-07-21 12:00",
      "temp_c": 30.0,
      "temp_f": 86.0,
      "is_day": 1,
      "condition": {
        "text": "Sunny",
        "icon": "//icon.png",
        "code": 1000
      },
      "wind_mph": 5.0,
      "wind_kph": 8.0,
      "wind_degree": 270,
      "wind_dir": "W",
      "pressure_mb": 1000,
      "pressure_in": 29.5,
      "precip_mm": 0,
      "precip_in": 0,
      "humidity": 50,
      "cloud": 0,
      "feelslike_c": 33.0,
      "feelslike_f": 91.0,
      "windchill_c": 29.0,
      "windchill_f": 84.0,
      "heatindex_c": 32.0,
      "heatindex_f": 90.0,
      "dewpoint_c": 15.0,
      "dewpoint_f": 59.0,
      "vis_km": 10,
      "vis_miles": 6,
      "uv": 7.0,
      "gust_mph": 10.0,
      "gust_kph": 15.0,
      "air_quality": {
        "co": 200.0,
        "no2": 10.0,
        "o3": 100.0,
        "so2": 5.0,
        "pm2_5": 20.0,
        "pm10": 30.0,
        "us-epa-index": 2,
        "gb-defra-index": 2
      }
    }
  };

  test('fetchWeather returns WeatherResponse on 200 OK', () async {
    // Arrange
    when(mockApiClient.getData(any, query: anyNamed('query'), handleError: anyNamed('handleError')))
        .thenAnswer((_) async => Response(
      statusCode: 200,
      body: fakeResponseJson,
      request: Request(
        method: 'GET',
        url: Uri.parse(''),
        headers: {},
      )

    ));

    // Act
    final result = await repository.fetchWeather(query);

    // Assert
    expect(result.location.name, 'Damascus');
    expect(result.current.condition.text, 'Sunny');
    expect(result.current.tempC, 30.0);
  });

  test('fetchWeather throws exception on non-200', () async {
    // Arrange
    when(mockApiClient.getData(any, query: anyNamed('query'), handleError: anyNamed('handleError')))
        .thenAnswer((_) async => Response(
      statusCode: 500,
      body: {'error': 'Internal Server Error'},
      request: Request(
        method: 'GET',
        url: Uri.parse(''),
        headers: {},
      )

    ));

    // Act & Assert
    expect(() => repository.fetchWeather(query), throwsException);
  });
}
