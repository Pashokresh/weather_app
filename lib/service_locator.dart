import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/data/weather_data_source.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/data/weather_use_case.dart';
import 'package:weather_app/router.dart';
import 'package:weather_app/ui/weather_view_model.dart';

final routerProvider = Provider((ref) => WeatherRouter());

final weatherDataSourceProvider = Provider((ref) => ApiWeatherDataSource());

final weatherRepositoryProvider = Provider(
  (ref) =>
      WeatherRepository(weatherDataSource: ref.read(weatherDataSourceProvider)),
);

final getWeatherUseCaseProvider = Provider(
  (ref) =>
      GetWeatherUseCase(weatherRepository: ref.read(weatherRepositoryProvider)),
);

final weatherViewModelProvider = Provider(
      (ref) =>
      WeatherViewModel(getWeatherUseCase: ref.watch(getWeatherUseCaseProvider)),
);
