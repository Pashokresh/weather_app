import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/weather_data_source.dart';


class WeatherRepository {
  WeatherRepository({required this.weatherDataSource});

  final WeatherDataSource weatherDataSource;

  Future<WeatherForecastsResponse> getWeather() =>
    weatherDataSource.getWeather();
}
