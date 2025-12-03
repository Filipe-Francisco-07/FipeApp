import 'package:get/get.dart';
import '../models/fipe_models.dart';
import '../services/fipe_service.dart';

class FipeController extends GetxController {
  final FipeService service = FipeService(vehicleType: 'carros');

  var brands = <FipeBrand>[].obs;
  var models = <FipeModel>[].obs;
  var years = <FipeYear>[].obs;

  var filteredBrands = <FipeBrand>[].obs;
  var filteredModels = <FipeModel>[].obs;
  var filteredYears = <FipeYear>[].obs;

  Rx<FipeBrand?> selectedBrand = Rx<FipeBrand?>(null);
  Rx<FipeModel?> selectedModel = Rx<FipeModel?>(null);
  Rx<FipeYear?> selectedYear = Rx<FipeYear?>(null);

  var isLoadingBrands = false.obs;
  var isLoadingModels = false.obs;
  var isLoadingYears = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBrands();
  }

  Future<void> loadBrands() async {
    isLoadingBrands.value = true;
    try {
      final data = await service.getBrands();
      brands.assignAll(data);
      filteredBrands.assignAll(data);
    } catch (e) {
      // colocar o negocio
    } finally {
      isLoadingBrands.value = false;
    }
  }

  Future<void> loadModels(FipeBrand brand) async {
    isLoadingModels.value = true;

    selectedBrand.value = brand;
    selectedModel.value = null;
    selectedYear.value = null;

    models.clear();
    filteredModels.clear();
    years.clear();
    filteredYears.clear();

    try {
      final data = await service.getModels(brand.codigo);
      models.assignAll(data);
      filteredModels.assignAll(data);
    } finally {
      isLoadingModels.value = false;
    }
  }

  Future<void> loadYears(FipeBrand brand, FipeModel model) async {
    isLoadingYears.value = true;

    selectedModel.value = model;
    selectedYear.value = null;

    years.clear();
    filteredYears.clear();

    try {
      final data = await service.getYears(brand.codigo, model.codigo);
      years.assignAll(data);
      filteredYears.assignAll(data);
    } finally {
      isLoadingYears.value = false;
    }
  }

  Future<FipeVehicleDetail?> getDetail() async {
    if (selectedBrand.value == null ||
        selectedModel.value == null ||
        selectedYear.value == null) {
      return null;
    }

    return await service.getVehicleDetail(
      selectedBrand.value!.codigo,
      selectedModel.value!.codigo,
      selectedYear.value!.codigo,
    );
  }

  void filterBrands(String q) {
    final query = q.toLowerCase();
    filteredBrands.value = brands
        .where((b) => b.nome.toLowerCase().contains(query))
        .toList();
  }

  void filterModels(String q) {
    final query = q.toLowerCase();
    filteredModels.value = models
        .where((m) => m.nome.toLowerCase().contains(query))
        .toList();
  }

  void filterYears(String q) {
    final query = q.toLowerCase();
    filteredYears.value = years
        .where((y) => y.nome.toLowerCase().contains(query))
        .toList();
  }
}
