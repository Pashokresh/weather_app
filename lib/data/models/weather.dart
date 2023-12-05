import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class WeatherForecastsResponse {
  WeatherForecastsResponse({required this.forecasts});

  factory WeatherForecastsResponse.fromJson(Map<String, dynamic> json) {
    json['forecasts'] ??= json['list'];

    return _$WeatherForecastsResponseFromJson(json);
  }

  final List<WeatherForecast> forecasts;
}

@JsonSerializable()
class WeatherForecast {
  WeatherForecast({
    required this.weather,
    required this.main,
    required this.dateTime,
    required this.wind,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    json['dateTime'] ??= json['dt'];

    return _$WeatherForecastFromJson(json);
  }

  @JsonKey(fromJson: _fromJson)
  final DateTime dateTime;
  final List<Weather> weather;
  final MainWeatherInfo main;
  final Wind wind;

  static DateTime _fromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int * 1000);
}

@JsonSerializable()
class Wind {
  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) =>
      _$WindFromJson(json);

  final double speed;
}

@JsonSerializable()
class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  final int id;
  final String main;
  final String description;
  final String icon;
}

extension WeatherIconUrl on Weather {
  String get bigIconUrl =>
      'https://openweathermap.org/img/wn/$icon@4x.png';

  String get smallIconUrl =>
      'https://openweathermap.org/img/wn/$icon@2x.png';
}

@JsonSerializable()
class MainWeatherInfo {
  MainWeatherInfo({
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
  });

  factory MainWeatherInfo.fromJson(Map<String, dynamic> json) {
    json['tempMin'] ??= json['temp_min'];
    json['tempMax'] ??= json['temp_max'];

    return _$MainWeatherInfoFromJson(json);
  }

  final double temp;
  final int pressure;
  final int humidity;
  final double tempMin;
  final double tempMax;
}
