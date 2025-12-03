import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/fipe_models.dart';

class FavoritesController extends GetxController {
  RxList<FipeVehicleDetail> favorites = <FipeVehicleDetail>[].obs;

  static const String storageKey = 'favorite_cars';

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(storageKey);

    if (jsonString != null) {
      final List<dynamic> decoded = jsonDecode(jsonString);
      favorites.value =
          decoded.map((e) => FipeVehicleDetail.fromJson(e)).toList();
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(favorites.map((e) => e.toJson()).toList());
    await prefs.setString(storageKey, jsonString);
  }

  Future<void> addFavorite(FipeVehicleDetail car) async {
    if (!isFavorite(car)) {
      favorites.add(car);
      await _saveToStorage();
    }
  }

  Future<void> removeFavorite(FipeVehicleDetail car) async {
    favorites.removeWhere((e) =>
        e.codigoFipe == car.codigoFipe &&
        e.anoModelo == car.anoModelo &&
        e.modelo == car.modelo);
    await _saveToStorage();
  }

  bool isFavorite(FipeVehicleDetail car) {
    return favorites.any((e) =>
        e.codigoFipe == car.codigoFipe &&
        e.anoModelo == car.anoModelo &&
        e.modelo == car.modelo);
  }
}
