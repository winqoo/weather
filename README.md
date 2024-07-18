# Weather App

A simple Flutter application to look up the weather for any location. This project demonstrates the use of Flutter with the Cubit state management pattern.

## Features

- **Search Weather:** Enter a city name to get the current weather forecast for that location.
- **Toggle Units:** Switch between the metric (Celsius) and imperial (Fahrenheit) system when displaying temperature units.
- **Refresh Weather:** Refresh the weather data for the selected location.

## Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- An API key from OpenWeatherMap: [Get API Key](https://openweathermap.org/api)

### Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/weather_app.git
    ```
2. **Navigate to the project directory:**
    ```bash
    cd weather_app
    ```
3. **Install the dependencies:**
    ```bash
    flutter pub get
    ```

### Running the Application

1**Run the application:**
    ```bash
    flutter run
    ```

### Testing

This project includes unit tests for the WeatherCubit. To run the tests, use the following command:

```bash
flutter test
```

### Project Structure
lib/
    features/weather/
        services/weather_service.dart
        cubit/weather_cubit.dart
              weather_state.dart
        screens/weather_screen.dart
main.dart