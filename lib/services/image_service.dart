import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageService {
  Future<String?> getRealCarImage(String marca, String modelo) async {
    final query = Uri.encodeComponent('$marca $modelo');

    final url = Uri.parse(
      'https://cars.arcanite.dev/api/models?search=$query',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body);

    if (data is List && data.isNotEmpty) {
      final first = data.first;
      if (first is Map<String, dynamic>) {
        final image = first['image'];
        if (image is String && image.isNotEmpty) {
          return image;
        }
      }
    }

    return null;
  }

  String getFallbackImage(String modelo) {
    return 'https://source.unsplash.com/800x600/?car,${Uri.encodeComponent(modelo)}';
  }
}
