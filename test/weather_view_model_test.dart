import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/weather_data_source.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/data/weather_use_case.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/ui/weather_view_model.dart';

import 'provider_container.dart';
import 'read_mocked_data.dart';
import 'weather_view_model_test.mocks.dart';

@GenerateMocks([WeatherDataSource])
void main() {
  group('WeatherViewModel tests', () {
    WidgetsFlutterBinding.ensureInitialized();

    final weatherDataSource = MockWeatherDataSource();

    when(weatherDataSource.getWeather()).thenAnswer((_) async {
      final mocked = await readMockedData();
      final weatherForecasts = WeatherForecastsResponse.fromJson(
        mocked as Map<String, dynamic>,
      );
      return Future.value(weatherForecasts);
    });

    final weatherRepository =
        WeatherRepository(weatherDataSource: weatherDataSource);
    final getWeatherUseCase =
        GetWeatherUseCase(weatherRepository: weatherRepository);
    final weatherViewModel =
        WeatherViewModel(getWeatherUseCase: getWeatherUseCase);

    test('Should get mocked weather successfully', () async {
      final result = await weatherViewModel.getWeather();
      expect(result, isNot(null));
    });

    test('Should get weather from API successfully', () async {
      final container = createContainer();
      final weatherViewModel = container.read(weatherViewModelProvider);
      final weather = await weatherViewModel.getWeather();
      expect(weather, isNot(null));
    });

    test('Big icon URL should be correct', () async {
      final weatherResponse = await weatherViewModel.getWeather();
      final weather = weatherResponse.forecasts.first.weather.first;
      final bigIconUrl =
          'https://openweathermap.org/img/wn/${weather.icon}@4x.png';
      expect(weather.bigIconUrl, bigIconUrl);
    });

    test('Small icon URL should be correct', () async {
      final weatherResponse = await weatherViewModel.getWeather();
      final weather = weatherResponse.forecasts.first.weather.first;
      final smallIconUrl =
          'https://openweathermap.org/img/wn/${weather.icon}@2x.png';
      expect(weather.smallIconUrl, smallIconUrl);
    });

    test('Should handle error from data source', () async {
      when(weatherDataSource.getWeather()).thenThrow(Exception('Mocked error'));
      expect(weatherViewModel.getWeather, throwsA(isA<Exception>()));
    });
  });
}
