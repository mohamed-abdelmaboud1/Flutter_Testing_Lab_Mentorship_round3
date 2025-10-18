import 'dart:async';

import 'package:flutter_testing_lab/core/services/weather_service.dart';

/// A synchronous mock weather service for testing - doesn't use Future.delayed
class MockWeatherService implements WeatherService {
  Map<String, Map<String, dynamic>>? mockData;
  bool shouldThrowError;
  int callCount = 0;

  MockWeatherService({this.mockData, this.shouldThrowError = false});

  @override
  Future<Map<String, dynamic>?> fetchWeatherData(String city) {
    // Increment call count to track refresh calls
    callCount++;

    // Return immediately without using Future.delayed
    if (shouldThrowError) {
      return Future.error(Exception('Mock API error'));
    }

    if (mockData != null && mockData!.containsKey(city)) {
      return Future.value(mockData![city]);
    }

    if (city == 'Invalid City') {
      return Future.value({});
    }

    return Future.value({
      'city': city,
      'temperature': 22.5,
      'description': 'Sunny (Mock)',
      'humidity': 65,
      'windSpeed': 10.0,
      'icon': '☀️',
    });
  }
}
