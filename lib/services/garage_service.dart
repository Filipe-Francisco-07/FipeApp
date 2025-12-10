import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/local_car.dart';

class GarageService {
  static const String baseUrl = 'http://localhost:8080';

  Future<List<LocalCar>> getCars() async {
    final uri = Uri.parse('$baseUrl/list.php');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((e) => LocalCar.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Erro ao carregar carros da garagem');
  }

  Future<LocalCar> addCar(LocalCar car) async {
    final uri = Uri.parse('$baseUrl/store.php');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      if (data.isEmpty) {
        throw Exception('Erro do server');
      }
      return LocalCar.fromJson(data.first as Map<String, dynamic>);
    }

    throw Exception('Erro ao salvar carro (status ${response.statusCode})');
  }
}
