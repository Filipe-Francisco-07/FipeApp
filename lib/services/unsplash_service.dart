import 'dart:convert';
import 'package:http/http.dart' as http;

class UnsplashService {
  
  static const String accessKey = "W1ytUZv4HLyJwWbVkooiCFXUYDauywHsKPUO9JKtyNQ";

  Future<String?> searchCarImage(
    String marca,
    String modelo, {
    String? ano,
    String? combustivel,
  }) async {

    final buffer = StringBuffer();
    buffer.write(marca);
    buffer.write(' ');
    buffer.write(modelo);

    if (ano != null && ano.trim().isNotEmpty) {
      buffer.write(' ');
      buffer.write(ano.trim());
    }

    if (combustivel != null && combustivel.trim().isNotEmpty) {
      buffer.write(' ');
      buffer.write(combustivel.trim());
    }

    buffer.write(' car');

    final query = buffer.toString();

    final url = Uri.parse(
      "https://api.unsplash.com/search/photos"
      "?query=$query&orientation=landscape&per_page=1",
    );

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Client-ID $accessKey",
        },
      );

      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body);

      if (json["results"] == null || json["results"].isEmpty) {
        return null;
      }

      return json["results"][0]["urls"]["regular"];
    } catch (_) {
      return null;
    }
  }
}
