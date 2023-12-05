import 'dart:convert';

import 'package:flutter/services.dart';

dynamic readMockedData() async {
  final response = await rootBundle.loadString('assets/mocked_data.json');
  return jsonDecode(response);
}
