import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quanos_weather/features/weather/data/models.dart';

class WeatherService {
  final String apiKey = 'ae1cd7e57a32eaea7a080b870eeb3ef0';

  Future<WeatherResponse> fetchWeather(String city, bool isMetric) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=${isMetric ?'metric' :'imperial'}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = WeatherResponse.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
