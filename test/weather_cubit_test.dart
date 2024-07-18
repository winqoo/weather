import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quanos_weather/features/weather/cubit/weather_cubit.dart';
import 'package:quanos_weather/features/weather/data/weather_service.dart';
import 'package:quanos_weather/features/weather/data/models.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  late WeatherCubit weatherCubit;
  late MockWeatherService mockWeatherService;

  setUp(() {
    mockWeatherService = MockWeatherService();
    weatherCubit = WeatherCubit(mockWeatherService);

    registerFallbackValue(
      WeatherResponse(
        coord: Coord(lon: 0, lat: 0),
        weather: [Weather(id: 0, main: '', description: '', icon: '')],
        base: '',
        main: Main(
          temp: 0,
          feelsLike: 0,
          tempMin: 0,
          tempMax: 0,
          pressure: 0,
          humidity: 0,
          seaLevel: 0,
          grndLevel: 0,
        ),
        visibility: 0,
        wind: Wind(speed: 0, deg: 0),
        clouds: Clouds(all: 0),
        dt: 0,
        sys: Sys(type: 0, id: 0, country: '', sunrise: 0, sunset: 0),
        timezone: 0,
        id: 0,
        name: '',
        cod: 0,
      ),
    );
  });

  tearDown(() {
    weatherCubit.close();
  });

  group('WeatherCubit', () {
    const city = 'London';
    final weatherData = WeatherResponse(
      coord: Coord(lon: -0.1257, lat: 51.5085),
      weather: [Weather(id: 800, main: 'Clear', description: 'clear sky', icon: '01d')],
      base: 'stations',
      main: Main(
        temp: 15.0,
        feelsLike: 14.0,
        tempMin: 13.0,
        tempMax: 17.0,
        pressure: 1015,
        humidity: 67,
        seaLevel: 1015,
        grndLevel: 1013,
      ),
      visibility: 10000,
      wind: Wind(speed: 4.12, deg: 80),
      clouds: Clouds(all: 0),
      dt: 1605182400,
      sys: Sys(type: 1, id: 1414, country: 'GB', sunrise: 1605153963, sunset: 1605188566),
      timezone: 0,
      id: 2643743,
      name: 'London',
      cod: 200,
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when fetchWeather is called',
      build: () {
        when(() => mockWeatherService.fetchWeather(city, true))
            .thenAnswer((_) async => weatherData);
        return weatherCubit;
      },
      act: (cubit) => cubit.fetchWeather(city),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(weatherData: weatherData, isMetric: true, city: city),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherLoading, WeatherError] when fetchWeather fails',
      build: () {
        when(() => mockWeatherService.fetchWeather(city, false))
            .thenThrow(Exception('Failed to load weather'));
        return weatherCubit;
      },
      act: (cubit) => cubit.fetchWeather(city, isMetric: false),
      expect: () => [
        WeatherLoading(),
        const WeatherError(message: 'Exception: Failed to load weather'),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'emits [WeatherLoaded with toggled units] when toggleUnits is called',
      build: () {
        return weatherCubit;
      },
      seed: () => WeatherLoaded(weatherData: weatherData, isMetric: true, city: city),
      act: (cubit) => cubit.toggleUnits(),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(weatherData: weatherData, isMetric: false, city: city),
      ],
    );
  });
}
