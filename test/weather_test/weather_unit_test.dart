import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/core/helper/temperature_utils.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

void main() {
  group('WeatherData', () {
    test('fromJson handles complete data correctly', () {
      final json = {
        'city': 'New York',
        'temperature': 22.5,
        'description': 'Sunny',
        'humidity': 65,
        'windSpeed': 12.3,
        'icon': '☀️',
      };

      final weatherData = WeatherData.fromJson(json);

      expect(weatherData.city, 'New York');
      expect(weatherData.temperatureCelsius, 22.5);
      expect(weatherData.description, 'Sunny');
      expect(weatherData.humidity, 65);
      expect(weatherData.windSpeed, 12.3);
      expect(weatherData.icon, '☀️');
    });

    test('fromJson handles null data gracefully', () {
      final weatherData = WeatherData.fromJson(null);

      expect(weatherData.city, 'Unknown');
      expect(weatherData.temperatureCelsius, 0.0);
      expect(weatherData.description, 'No data available');
      expect(weatherData.humidity, null);
      expect(weatherData.windSpeed, null);
      expect(weatherData.icon, '❓');
    });

    test('fromJson handles empty data gracefully', () {
      final weatherData = WeatherData.fromJson({});

      expect(weatherData.city, 'Unknown');
      expect(weatherData.temperatureCelsius, 0.0);
      expect(weatherData.description, 'No description'); // will fail 🥺🥺🥺
      expect(weatherData.humidity, null);
      expect(weatherData.windSpeed, null);
      expect(weatherData.icon, '❓');
    });

    test('fromJson handles partial data gracefully', () {
      final json = {'city': 'London', 'temperature': 15.0};

      final weatherData = WeatherData.fromJson(json);

      expect(weatherData.city, 'London');
      expect(weatherData.temperatureCelsius, 15.0);
      expect(weatherData.description, 'No description');
      expect(weatherData.humidity, null);
      expect(weatherData.windSpeed, null);
      expect(weatherData.icon, '❓'); // will fail ❌ 🥺🥺🥺
    });

    test('fromJson handles different types correctly', () {
      final json = {
        'city': 'Tokyo',
        'temperature': '25.0', // String instead of number
        'humidity': '70', // String instead of number
        'windSpeed': 5, // Integer instead of double
      };

      final weatherData = WeatherData.fromJson(json);

      expect(weatherData.city, 'Tokyo');
      expect(weatherData.temperatureCelsius, 25.0);
      expect(weatherData.humidity, 70);
      expect(weatherData.windSpeed, 5.0);
    });
  });

  group('Temperature conversion', () {
    test('celsiusToFahrenheit converts correctly', () {
      expect(TemperatureUtils.celsiusToFahrenheit(0), 32);
      expect(TemperatureUtils.celsiusToFahrenheit(100), 212);
      expect(TemperatureUtils.celsiusToFahrenheit(25), 77);
      expect(TemperatureUtils.celsiusToFahrenheit(-40), -40);
    });

    test('fahrenheitToCelsius converts correctly', () {
      expect(TemperatureUtils.fahrenheitToCelsius(32), 0);
      expect(TemperatureUtils.fahrenheitToCelsius(212), 100);
      expect(TemperatureUtils.fahrenheitToCelsius(77), closeTo(25, 0.01));
      expect(TemperatureUtils.fahrenheitToCelsius(-40), -40);
    });

    test('conversions are reversible', () {
      final testValues = [-50.0, -20.0, 0.0, 15.0, 25.0, 37.0, 100.0];

      for (final celsius in testValues) {
        final fahrenheit = TemperatureUtils.celsiusToFahrenheit(celsius);
        final backToCelsius = TemperatureUtils.fahrenheitToCelsius(fahrenheit);
        expect(backToCelsius, closeTo(celsius, 0.001));
      }
    });
  });
}
