import 'package:get/get.dart';
import '../models/fipe_models.dart';

class FavoritesController extends GetxController {

  final RxList<Map<String, dynamic>> favorites = <Map<String, dynamic>>[].obs;

  bool isFavorite(FipeVehicleDetail detail) {
    return favorites.any((f) => f["codigoFipe"] == detail.codigoFipe);
  }

  void addFavorite(FipeVehicleDetail detail, String? imageUrl) {
    favorites.add({
      "codigoFipe": detail.codigoFipe,
      "marca": detail.marca,
      "modelo": detail.modelo,
      "ano": detail.anoModelo,
      "preco": detail.valor,
      "combustivel": detail.combustivel,
      "imageUrl": imageUrl,
    });
  }

  void removeFavorite(FipeVehicleDetail detail) {
    favorites.removeWhere((f) => f["codigoFipe"] == detail.codigoFipe);
  }
}
