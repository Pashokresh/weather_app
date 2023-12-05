import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/models/weather.dart';

import 'read_mocked_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('WeatherForecast should deserialize correctly', () async {
    final result = await readMockedData();
    final forecast =
        WeatherForecastsResponse.fromJson(result as Map<String, dynamic>);

    expect(forecast, isNotNull);

    expect(forecast.forecasts, isNotNull);

    expect(forecast.forecasts, isNotEmpty);

    expect(forecast.forecasts[0].weather, isNotNull);
    expect(forecast.forecasts[0].weather, isNotEmpty);
  });
}
