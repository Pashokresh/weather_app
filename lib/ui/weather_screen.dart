import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/ui/detailed_weather_widget.dart';
import 'package:weather_app/ui/weather_carousel_item.dart';
import 'package:weather_app/ui/weather_error_widget.dart';

final weatherScreenProvider = FutureProvider.family(
  (ref, _) async => ref.watch(weatherViewModelProvider).getWeather(),
);

final selectedItemProvider = StateProvider<int>((ref) => 0);

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Theme.of(context).primaryColorLight,
        child: SafeArea(
          left: false,
          right: false,
          child: Consumer(
            builder: (context, ref, child) {
              final weatherState = ref.watch(weatherScreenProvider(ref));
              return RefreshIndicator(
                onRefresh: () async {
                  final _ = ref.refresh(weatherScreenProvider(ref));
                  ref.read(selectedItemProvider.notifier).state = 0;
                },
                child: CustomScrollView(
                  slivers: [
                    _buildWeatherSliver(weatherState, ref)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherSliver(
    AsyncValue<WeatherForecastsResponse> weatherState,
    WidgetRef ref,
  ) {
    return weatherState.when(
      skipLoadingOnRefresh: false,
      data: (weather) {
        final forecasts = weather.forecasts;
        final index = ref.watch(selectedItemProvider);
        return SliverToBoxAdapter(
          child: Column(
            children: [
              DetailedWeatherWidget(
                forecast: forecasts[index],
              ),
              const SizedBox(height: 40),
              _buildWeatherCarousel(forecasts, ref),
            ],
          ),
        );
      },
      error: (error, trace) => SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: WeatherErrorWidget(
            error: error,
            retry: () => ref.refresh(weatherScreenProvider(ref)),
          ),
        ),
      ),
      loading: () => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildWeatherCarousel(List<WeatherForecast> forecasts, WidgetRef ref) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        itemBuilder: (context, itemIndex) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              child: WeatherCarouselItem(
                forecast: forecasts[itemIndex],
              ),
              onTap: () {
                ref.read(selectedItemProvider.notifier).state = itemIndex;
              },
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: forecasts.length,
      ),
    );
  }
}
