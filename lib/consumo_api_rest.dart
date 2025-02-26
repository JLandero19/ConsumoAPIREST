import 'dart:convert';  // Para convertir la respuesta en JSON
import 'dart:io';
import 'package:consumo_api_rest/validator.dart';
import 'package:consumo_api_rest/weather_info.dart';
import 'package:http/http.dart' as http;  // Paquete para hacer la llamada HTTP

// Función para obtener el clima de una ciudad
Future<WeatherInfo?> getWeather(String cityName) async {
  // Asegúrate de reemplazar 'YOUR_API_KEY' con tu propia clave de API de OpenWeather
  const apiKey = '02ae6e3c228becd6811e75cece1ed26a'; 
  final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric&lang=es');
  try {
    // Realizamos la solicitud HTTP
    final response = await http.get(url);

    // Verificamos si la solicitud fue exitosa
    if (response.statusCode == 200) {
      // Convertimos la respuesta en formato JSON
      final data = json.decode(response.body);

      WeatherInfo wheatherInfo = WeatherInfo(
        city: data['name'],
        description: data['weather'][0]['description'], 
        temperature: data['main']['temp'], 
        humidity: data['main']['humidity'], 
        windSpeed: data['wind']['speed']
      );

      return wheatherInfo;
    } else {
      print('Error en la llamada a la API: ${response.statusCode}');
    }
  } catch (e) {
    print('Ocurrió un error: $e');
  }

  return null;
}

void main() async {  
  String? city;
  // Pregunta por la ciudad que se quiere saber el tiempo
  do {
    print("Introduce el nombre de una ciudad:");
    city = stdin.readLineSync();
    if (city != null) {
      if (!Validator.isValidText(city!)) {
        print("ERROR El texto introducido no es válido.");
      }
    } else {
      print("ERROR La ciudad es requerida.");
    }
  } while (city == null || city == "");
  
  // Llamada a la función para obtener el clima de Madrid
  WeatherInfo? weatherInfo = await getWeather(city);
  
  // Si el resultado no es nulo, muestra los resultados
  if (weatherInfo != null) {
    print("Ciudad: ${weatherInfo.city}");
    print("Descripción: ${weatherInfo.description}");
    print("Temperatura: ${weatherInfo.temperature} ºC");
    print("Humedad: ${weatherInfo.humidity}%");
    print("Velocidad del viento: ${weatherInfo.windSpeed}");
  }
}