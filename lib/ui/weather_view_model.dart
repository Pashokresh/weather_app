import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/weather_use_case.dart';

class WeatherViewModel {
  WeatherViewModel({required GetWeatherUseCase getWeatherUseCase}):
  _getWeatherUseCase = getWeatherUseCase;

  final GetWeatherUseCase _getWeatherUseCase;

  Future<WeatherForecastsResponse> getWeather() {
    return _getWeatherUseCase.getWeather();
  }
}
