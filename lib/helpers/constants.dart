abstract class Constants {
  static const String openWeatherMapApiUrl = String.fromEnvironment(
    'OPENWEATHERMAP_API_URL',
    defaultValue: 'https://api.openweathermap.org/data/2.5',
  );

  static const String openWeatherMapApiKey = String.fromEnvironment(
    'OPENWEATHERMAP_API_KEY',
    defaultValue: '9b423a8c22a9141aad5651901189406c',
  );
}
