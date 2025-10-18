import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

import 'mock_weather_service.dart';

void main() {
  // Create a test-friendly WeatherDisplay with a mock service
  WeatherDisplay createTestableWeatherDisplay({
    MockWeatherService? mockService,
  }) {
    return WeatherDisplay(weatherService: mockService ?? MockWeatherService());
  }

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('WeatherDisplay shows temperature toggle functionality', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: createTestableWeatherDisplay())),
    );

    // Check for toggle switch
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('Celsius'), findsOneWidget);
    expect(find.text('Fahrenheit'), findsNothing);

    // Toggle to Fahrenheit
    await tester.tap(find.byType(Switch));
    await tester.pump();

    // Should now show Fahrenheit
    expect(find.text('Fahrenheit'), findsOneWidget);
    expect(find.text('Celsius'), findsNothing);
  });

  testWidgets('WeatherDisplay shows UI elements for city selection', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: createTestableWeatherDisplay())),
    );

    // Check for city selection dropdown
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(find.text('City:'), findsOneWidget);

    // Check for refresh button
    expect(find.text('Refresh'), findsOneWidget);
  });

  testWidgets('WeatherDisplay shows weather data after loading', (
    WidgetTester tester,
  ) async {
    // Create a mock service with pre-defined data
    final mockService = MockWeatherService(
      mockData: {
        'New York': {
          'city': 'New York',
          'temperature': 22.5,
          'description': 'Sunny',
          'humidity': 65,
          'windSpeed': 10.0,
          'icon': '☀️',
        },
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: createTestableWeatherDisplay(mockService: mockService),
        ),
      ),
    );

    // Initially should show loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the mock data to load
    await tester.pumpAndSettle();

    // Should now show the weather data
    expect(find.text('New York'), findsOneWidget);
    expect(find.text('22.5°C'), findsOneWidget);
    expect(find.text('Sunny'), findsOneWidget);
    expect(find.text('65%'), findsOneWidget);
    expect(find.text('10.0 km/h'), findsOneWidget);
  });

  testWidgets('WeatherDisplay shows error state when API fails', (
    WidgetTester tester,
  ) async {
    // Create a mock service that throws an error
    final mockService = MockWeatherService(shouldThrowError: true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: createTestableWeatherDisplay(mockService: mockService),
        ),
      ),
    );

    // Initially should show loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the error to be processed
    await tester.pumpAndSettle();

    // Should show error state with retry button
    expect(find.text('Try Again'), findsOneWidget);
    expect(find.textContaining('Error:'), findsOneWidget);
  });

  testWidgets('WeatherDisplay shows error for Invalid City', (
    WidgetTester tester,
  ) async {
    // Create a mock service that returns empty data for Invalid City
    final mockService = MockWeatherService(mockData: {'Invalid City': {}});

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: createTestableWeatherDisplay(mockService: mockService),
        ),
      ),
    );

    // Wait for initial load
    await tester.pumpAndSettle();

    // Select "Invalid City" from dropdown
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Invalid City').last);
    await tester.pumpAndSettle();

    // Should show error state
    expect(find.textContaining('Failed to load weather data'), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);
  });

  testWidgets('WeatherDisplay changes city correctly', (
    WidgetTester tester,
  ) async {
    // Create mock service with different cities
    final mockService = MockWeatherService(
      mockData: {
        'New York': {
          'city': 'New York',
          'temperature': 22.5,
          'description': 'Sunny',
          'humidity': 65,
          'windSpeed': 10.0,
          'icon': '☀️',
        },
        'London': {
          'city': 'London',
          'temperature': 15.0,
          'description': 'Rainy',
          'humidity': 85,
          'windSpeed': 8.5,
          'icon': '🌧️',
        },
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: createTestableWeatherDisplay(mockService: mockService),
        ),
      ),
    );

    // Wait for New York data to load
    await tester.pumpAndSettle();
    expect(find.text('New York'), findsOneWidget);
    expect(find.text('22.5°C'), findsOneWidget);
    expect(find.text('Sunny'), findsOneWidget);

    // Change to London
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('London').last);
    await tester.pumpAndSettle();

    // Should show London data
    expect(find.text('London'), findsOneWidget);
    expect(find.text('15.0°C'), findsOneWidget);
    expect(find.text('Rainy'), findsOneWidget);
    expect(find.text('85%'), findsOneWidget);
  });


}
