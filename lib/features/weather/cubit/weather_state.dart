part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherResponse weatherData;
  final bool isMetric;
  final String city;

  const WeatherLoaded({
    required this.weatherData,
    required this.isMetric,
    required this.city,
  });

  WeatherLoaded copyWith({
    WeatherResponse? weatherData,
    bool? isMetric,
    String? city,
  }) {
    return WeatherLoaded(
      weatherData: weatherData ?? this.weatherData,
      isMetric: isMetric ?? this.isMetric,
      city: city ?? this.city,
    );
  }

  @override
  List<Object> get props => [weatherData, isMetric, city];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError({required this.message});

  @override
  List<Object> get props => [message];
}
