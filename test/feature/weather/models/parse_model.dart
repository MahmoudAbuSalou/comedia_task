import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';

void main() {
  group('WeatherResponse.fromJson', () {
    test('parses correctly', () {
      final json = {
        "location": {
          "name": "Nawa",
          "region": "Dar",
          "country": "Syria",
          "lat": 32.883,
          "lon": 36.05,
          "tz_id": "Asia/Damascus",
          "localtime_epoch": 1753114087,
          "localtime": "2025-07-21 19:08"
        },
        "current": {
          "last_updated_epoch": 1753113600,
          "last_updated": "2025-07-21 19:00",
          "temp_c": 34.1,
          "temp_f": 93.4,
          "is_day": 1,
          "condition": {
            "text": "Sunny",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
            "code": 1000
          },
          "wind_mph": 11.4,
          "wind_kph": 18.4,
          "wind_degree": 266,
          "wind_dir": "W",
          "pressure_mb": 1005.0,
          "pressure_in": 29.68,
          "precip_mm": 0.0,
          "precip_in": 0.0,
          "humidity": 34,
          "cloud": 0,
          "feelslike_c": 37.2,
          "feelslike_f": 98.9,
          "windchill_c": 27.5,
          "windchill_f": 81.5,
          "heatindex_c": 27.6,
          "heatindex_f": 81.7,
          "dewpoint_c": 13.9,
          "dewpoint_f": 57.0,
          "vis_km": 10.0,
          "vis_miles": 6.0,
          "uv": 0.1,
          "gust_mph": 15.9,
          "gust_kph": 25.6,
          "air_quality": {
            "co": 223.85,
            "no2": 1.85,
            "o3": 122.0,
            "so2": 2.775,
            "pm2_5": 23.31,
            "pm10": 29.415,
            "us-epa-index": 2,
            "gb-defra-index": 2
          }
        }
      };

      final weather = WeatherResponse.fromJson(json);

      expect(weather.location.name, 'Nawa');
      expect(weather.location.country, 'Syria');
      expect(weather.current.condition.text, 'Sunny');
      expect(weather.current.tempC, 34.1);
      expect(weather.current.humidity, 34);
      expect(weather.current.airQuality.usEpaIndex, 2);
    });
  });
}
