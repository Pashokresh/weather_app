import 'package:flutter/material.dart';
import 'package:weather_app/data/utils/extensions.dart';

class WeatherErrorWidget extends StatelessWidget {
  const WeatherErrorWidget({
    required this.error,
    required this.retry,
    super.key,
  });

  final Object error;
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_amber_outlined,
          color: context.colorTheme.error,
        ),
        const SizedBox(height: 8),
        Text(
          'Something went wrong',
          style: context.textTheme.titleLarge,
        ),
        const Text('An error occurred while fetching weather data.'),
        const SizedBox(height: 8),
        OutlinedButton(onPressed: retry, child: const Text('Try again'))
      ],
    );
  }
}
