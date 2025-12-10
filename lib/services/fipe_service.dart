import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/fipe_models.dart';

class FipeService {
  static const String _baseUrl = 'https://parallelum.com.br/fipe/api/v1';

  final String vehicleType;

  FipeService({this.vehicleType = 'carros'});

  Future<List<FipeBrand>> getBrands() async {
    final uri = Uri.parse('$_baseUrl/$vehicleType/marcas');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((e) => FipeBrand.fromJson(e as Map<String, dynamic>)).toList();
    }

    throw Exception('Erro ao carregar marcas FIPE');
  }

  Future<List<FipeModel>> getModels(String brandCode) async {
    final uri = Uri.parse('$_baseUrl/$vehicleType/marcas/$brandCode/modelos');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> modelos = data['modelos'] as List<dynamic>;
      return modelos
          .map((e) => FipeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Erro ao carregar modelos FIPE');
  }

  Future<List<FipeYear>> getYears(String brandCode, String modelCode) async {
    final uri =
        Uri.parse('$_baseUrl/$vehicleType/marcas/$brandCode/modelos/$modelCode/anos');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((e) => FipeYear.fromJson(e as Map<String, dynamic>)).toList();
    }

    throw Exception('Erro ao carregar anos FIPE');
  }

  Future<FipeVehicleDetail> getVehicleDetail(
    String brandCode,
    String modelCode,
    String yearCode,
  ) async {
    final uri = Uri.parse(
        '$_baseUrl/$vehicleType/marcas/$brandCode/modelos/$modelCode/anos/$yearCode');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return FipeVehicleDetail.fromJson(data);
    }

    throw Exception('Erro ao carregar detalhes do veículo');
  }
}
