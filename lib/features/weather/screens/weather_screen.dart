import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quanos_weather/features/weather/cubit/weather_cubit.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                context.read<WeatherCubit>().fetchWeather(_controller.text);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context.read<WeatherCubit>().fetchWeather(_controller.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return const Text('Please enter a city to get the weather.');
                } else if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text(
                        '${state.weatherData.name}, ${state.weatherData.sys.country}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${state.weatherData.main.temp} ${state.isMetric ? '°C' : '°F'}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        state.weatherData.weather[0].description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Text('Error: ${state.message}');
                } else {
                  return Container();
                }
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<WeatherCubit>().toggleUnits();
                if (_controller.text.isNotEmpty) {
                  context.read<WeatherCubit>().fetchWeather(_controller.text);
                }
              },
              child: const Text('Toggle Units'),
            ),
          ],
        ),
      ),
    );
  }
}
