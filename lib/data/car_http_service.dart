import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/car_model.dart';
import '../utils/const_app.dart';

class CarHttpService {
  final String _baseUrl = 'https://car-data.p.rapidapi.com';
  final String _apiKey = '8d82667381msh3928365d586418bp10493fjsn1a7ae6016b73';
  final String _apiHost = 'car-data.p.rapidapi.com';

  Future<List<Car>> getCars() async {
    final uri = Uri.parse('$_baseUrl/cars');
    final response = await http.get(
      uri,
      headers: {
        'x-rapidapi-key': _apiKey,
        'x-rapidapi-host': _apiHost,
      },
    );

    if (response.statusCode == 200) {
      return Car.listFromJson(response.body);
    }

    throw Exception('$messageErrorCarsApi: ${response.statusCode}');
  }

  Future<List<String>> getBrands() async {
    final uri = Uri.parse('$_baseUrl$endPointBrands');
    final response = await http.get(
      uri,
      headers: {
        'x-rapidapi-key': _apiKey,
        'x-rapidapi-host': _apiHost,
      },
    );

    if (response.statusCode == 200) {
      return _brandsFromJson(response.body);
    }

    throw Exception(messageErrorBrandApi);
  }

  List<String> _brandsFromJson(String responseBody) {
    return List<String>.from(json.decode(responseBody) as List<dynamic>);
  }
}
