import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/weather_repository.dart';

class GetWeatherUseCase {
  GetWeatherUseCase({required this.weatherRepository});

  final WeatherRepository weatherRepository;

  Future<WeatherForecastsResponse> getWeather() {
    return weatherRepository.getWeather();
  }
}
