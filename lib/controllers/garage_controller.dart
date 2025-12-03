import 'package:get/get.dart';
import '../models/local_car.dart';
import '../services/garage_service.dart';

class GarageController extends GetxController {
  final GarageService service = GarageService();

  var cars = <LocalCar>[].obs;
  var isLoading = false.obs;
  var isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCars();
  }

  Future<void> loadCars() async {
    isLoading.value = true;
    try {
      final result = await service.getCars();
      cars.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCar(LocalCar car) async {
    isSaving.value = true;
    try {
      await service.addCar(car);
      await loadCars();
    } finally {
      isSaving.value = false;
    }
  }
}
