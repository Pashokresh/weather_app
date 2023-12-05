import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/weather_data_source.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/data/weather_use_case.dart';
import 'package:weather_app/router.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/ui/weather_view_model.dart';

import 'provider_container.dart';


void main() {
  group('Test providers', () {

    late ProviderContainer container;

    setUp(() {
      container = createContainer();
    });

    test('WeatherDataSource Provider', () {
      expect(
        container.read(weatherDataSourceProvider),
        isA<ApiWeatherDataSource>()
      );
    });

    test('WeatherRepository Provider', () {
      expect(
        container.read(weatherRepositoryProvider),
          isA<WeatherRepository>(),
      );
    });

    test('GetWeatherUseCase Provider', () {
      expect(
        container.read(getWeatherUseCaseProvider),
          isA<GetWeatherUseCase>(),
      );
    });

    test('WeatherScreenViewModel Provider', () {
      expect(
        container.read(weatherViewModelProvider),
        isA<WeatherViewModel>(),
      );
    });

    test('Router Provider', () {
      expect(container.read(routerProvider), isA<WeatherRouter>());
    });
  });
}
