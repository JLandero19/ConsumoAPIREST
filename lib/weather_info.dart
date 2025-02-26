class WeatherInfo {
    final String city;
    final String description;
    final double temperature;
    final int humidity;
    final double windSpeed;

    WeatherInfo(
        {
            required this.city,
            required this.description,
            required this.temperature,
            required this.humidity,
            required this.windSpeed,
        }
    );

    factory WeatherInfo.fromJson(Map<String, dynamic> json) {
        return WeatherInfo(
            city: json["name"],
            description: json['weather'][0]['description'],
            temperature: json['main']['temp'].toDouble(),
            humidity: json['main']['humidity'],
            windSpeed: json['wind']['speed'].toDouble(),
        );
    }

    String getDescription() => description;
    double getTemperature() => temperature;
    int getHumidity() => humidity;
    double getWindSpeed() => windSpeed;
}