import 'package:dio/dio.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/utils/constants.dart';

const _baseUrl = 'https://api.openweathermap.org/data/2.5';

abstract class WeatherDataSource {
  Future<WeatherForecastsResponse> getWeather();
}

class ApiWeatherDataSource implements WeatherDataSource {
  ApiWeatherDataSource({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  final Dio _dio;

  @override
  Future<WeatherForecastsResponse> getWeather() async {
    try {
      final response = await _dio.get<dynamic>(
        '/forecast',
        queryParameters: {
          'lat': 52.52,
          'lon': 13.40,
          'units': 'metric',
          'apiKey': apiKey
        },
      );
      return WeatherForecastsResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException {
      rethrow;
    }
  }
}
