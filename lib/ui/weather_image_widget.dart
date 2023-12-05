import 'package:flutter/material.dart';
import 'package:weather_app/data/utils/extensions.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) => Image.network(
        url,
        loadingBuilder: (context, child, event) => Center(
          child: event != null ? const CircularProgressIndicator() : child,
        ),
        errorBuilder: (context, error, trace) => Icon(
          Icons.error_outline_outlined,
          color: context.colorTheme.error,
        ),
      );
}
