class WeatherResponse {
  final Location location;
  final Current current;

  WeatherResponse({
    required this.location,
    required this.current,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat']?.toDouble(),
      lon: json['lon']?.toDouble(),
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }
}

class Current {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double windchillC;
  final double windchillF;
  final double heatindexC;
  final double heatindexF;
  final double dewpointC;
  final double dewpointF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;
  final AirQuality airQuality;

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
    required this.airQuality,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      lastUpdatedEpoch: json['last_updated_epoch'],
      lastUpdated: json['last_updated'],
      tempC: json['temp_c']?.toDouble(),
      tempF: json['temp_f']?.toDouble(),
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windMph: json['wind_mph']?.toDouble(),
      windKph: json['wind_kph']?.toDouble(),
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb']?.toDouble(),
      pressureIn: json['pressure_in']?.toDouble(),
      precipMm: json['precip_mm']?.toDouble(),
      precipIn: json['precip_in']?.toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c']?.toDouble(),
      feelslikeF: json['feelslike_f']?.toDouble(),
      windchillC: json['windchill_c']?.toDouble(),
      windchillF: json['windchill_f']?.toDouble(),
      heatindexC: json['heatindex_c']?.toDouble(),
      heatindexF: json['heatindex_f']?.toDouble(),
      dewpointC: json['dewpoint_c']?.toDouble(),
      dewpointF: json['dewpoint_f']?.toDouble(),
      visKm: json['vis_km']?.toDouble(),
      visMiles: json['vis_miles']?.toDouble(),
      uv: json['uv']?.toDouble(),
      gustMph: json['gust_mph']?.toDouble(),
      gustKph: json['gust_kph']?.toDouble(),
      airQuality: AirQuality.fromJson(json['air_quality']),
    );
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}

class AirQuality {
  final double co;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final int usEpaIndex;
  final int gbDefraIndex;

  AirQuality({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      co: json['co']?.toDouble(),
      no2: json['no2']?.toDouble(),
      o3: json['o3']?.toDouble(),
      so2: json['so2']?.toDouble(),
      pm2_5: json['pm2_5']?.toDouble(),
      pm10: json['pm10']?.toDouble(),
      usEpaIndex: json['us-epa-index'],
      gbDefraIndex: json['gb-defra-index'],
    );
  }
}
