import 'package:go_router/go_router.dart';
import 'package:weather_app/ui/weather_screen.dart';

class WeatherRouter {
  final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (context, state) => const WeatherScreen())
    ],
  );
}
