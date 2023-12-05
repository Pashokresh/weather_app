import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeDayOfWeek on DateTime {
  String get fullDayOfWeek  => DateFormat('EEEE').format(this);

  String get shortDayOfWeek => DateFormat('EE').format(this);
}

extension BuildContextExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorTheme => Theme.of(this).colorScheme;
}
