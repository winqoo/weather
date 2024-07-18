import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quanos_weather/features/weather/data/models.dart';
import 'package:quanos_weather/features/weather/data/weather_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;

  WeatherCubit(this.weatherService) : super(WeatherInitial());

  Future<void> fetchWeather(String city, {bool isMetric = true}) async {
    emit(WeatherLoading());
    try {
      final weatherData = await weatherService.fetchWeather(city, isMetric);
      emit(WeatherLoaded(weatherData: weatherData, isMetric: isMetric, city: city));
    } catch (e) {
      emit(WeatherError(message: e.toString()));
    }
  }

  void toggleUnits() {
    if (state is WeatherLoaded) {
      final currentState = state as WeatherLoaded;
      fetchWeather(currentState.city, isMetric: !currentState.isMetric);
    }
  }
}
