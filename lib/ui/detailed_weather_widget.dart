import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/utils/extensions.dart';
import 'package:weather_app/ui/weather_image_widget.dart';

class DetailedWeatherWidget extends StatelessWidget {
  const DetailedWeatherWidget({required this.forecast, super.key});

  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        _buildDateTime(context),
        const SizedBox(
          height: 16,
        ),
        _buildWeatherInfo(context),
      ],
    );
  }

  Widget _buildDateTime(BuildContext context) => Text(
        '${forecast.dateTime.fullDayOfWeek}, ${forecast.dateTime.hour}h',
        style: context.textTheme.titleLarge,
      );

  Widget _buildWeatherInfo(BuildContext context) {
    final weather = forecast.weather.first;
    final main = forecast.main;

    return Column(
      children: [
        Text(weather.main, style: context.textTheme.bodyLarge),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).shortestSide / 2,
          ),
          child: WeatherImage(url: weather.bigIconUrl),
        ),
        Text(
          '${main.temp.round()}\u00B0C',
          style: context.textTheme.headlineLarge,
        ),
        const SizedBox(
          height: 16,
        ),
        _buildInfoRow(label: 'Humidity', value: '${main.humidity}%'),
        _buildInfoRow(label: 'Pressure', value: '${main.pressure} mm Hg'),
        _buildInfoRow(label: 'Wind', value: '${forecast.wind.speed} m/s'),
      ],
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text('$label: $value'),
    );
  }
}
