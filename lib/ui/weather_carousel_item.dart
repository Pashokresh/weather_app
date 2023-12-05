import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/utils/extensions.dart';
import 'package:weather_app/ui/weather_image_widget.dart';

class WeatherCarouselItem extends StatelessWidget {
  const WeatherCarouselItem({required this.forecast, super.key});

  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
    if (forecast.weather.isEmpty) return Container();
    final weather = forecast.weather.first;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                '''${forecast.dateTime.shortDayOfWeek}, ${forecast.dateTime.hour}h''',
              ),
              SizedBox(
                height: 90,
                child: WeatherImage(
                  url: weather.smallIconUrl,
                ),
              ),
              Text(
                temperatureLabel(
                  minTemperature: forecast.main.tempMin,
                  maxTemperature: forecast.main.tempMax,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String temperatureLabel({
    required double minTemperature,
    required double maxTemperature,
  }) {
    final minTemp = minTemperature.round();
    final maxTemp = maxTemperature.round();

    return minTemp == maxTemp
        ? '$minTemp\u00B0C'
        : '$minTemp\u00B0C/$maxTemp\u00B0C';
  }
}
