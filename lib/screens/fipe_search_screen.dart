import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/fipe_controller.dart';
import '../models/fipe_models.dart';
import '../routes/app_routes.dart';

class FipeSearchScreen extends StatefulWidget {
  const FipeSearchScreen({super.key});

  @override
  State<FipeSearchScreen> createState() => _FipeSearchScreenState();
}

class _FipeSearchScreenState extends State<FipeSearchScreen> {
  late final FipeController c;

  final TextEditingController _brandSearchController = TextEditingController();
  final TextEditingController _modelSearchController = TextEditingController();
  final TextEditingController _yearSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    c = Get.put(FipeController());

    _brandSearchController.addListener(() {
      c.filterBrands(_brandSearchController.text);
    });
    _modelSearchController.addListener(() {
      c.filterModels(_modelSearchController.text);
    });
    _yearSearchController.addListener(() {
      c.filterYears(_yearSearchController.text);
    });
  }

  @override
  void dispose() {
    _brandSearchController.dispose();
    _modelSearchController.dispose();
    _yearSearchController.dispose();
    super.dispose();
  }

  Future<void> _goToDetail() async {
    final detail = await c.getDetail();

    if (detail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione marca, modelo e ano.')),
      );
      return;
    }

    if (!mounted) return;

    Navigator.of(context).pushNamed(
      AppRoutes.fipeDetail,
      arguments: detail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar na FIPE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selecione um veículo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _brandSearchController,
                decoration: const InputDecoration(
                  labelText: 'Pesquisar marca',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                if (c.isLoadingBrands.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return DropdownButtonFormField<FipeBrand>(
                  initialValue: c.selectedBrand.value,
                  decoration: const InputDecoration(
                    labelText: 'Marca',
                    border: OutlineInputBorder(),
                  ),
                  items: c.filteredBrands
                      .map(
                        (b) => DropdownMenuItem<FipeBrand>(
                          value: b,
                          child: Text(b.nome),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    c.loadModels(value);
                  },
                );
              }),
              const SizedBox(height: 16),

              TextField(
                controller: _modelSearchController,
                decoration: const InputDecoration(
                  labelText: 'Pesquisar modelo',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                if (c.isLoadingModels.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return DropdownButtonFormField<FipeModel>(
                  initialValue: c.selectedModel.value,
                  decoration: const InputDecoration(
                    labelText: 'Modelo',
                    border: OutlineInputBorder(),
                  ),
                  items: c.filteredModels
                      .map(
                        (m) => DropdownMenuItem<FipeModel>(
                          value: m,
                          child: Text(m.nome),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    if (c.selectedBrand.value != null) {
                      c.loadYears(c.selectedBrand.value!, value);
                    }
                  },
                );
              }),
              const SizedBox(height: 16),

              TextField(
                controller: _yearSearchController,
                decoration: const InputDecoration(
                  labelText: 'Pesquisar ano',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                if (c.isLoadingYears.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return DropdownButtonFormField<FipeYear>(
                  initialValue: c.selectedYear.value,
                  decoration: const InputDecoration(
                    labelText: 'Ano',
                    border: OutlineInputBorder(),
                  ),
                  items: c.filteredYears
                      .map(
                        (y) => DropdownMenuItem<FipeYear>(
                          value: y,
                          child: Text(y.nome),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    c.selectedYear.value = value;
                  },
                );
              }),
              const SizedBox(height: 24),

              Obx(() {
                final canGo = c.selectedBrand.value != null &&
                    c.selectedModel.value != null &&
                    c.selectedYear.value != null;

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.directions_car),
                    label: const Text('Ver detalhes'),
                    onPressed: canGo ? _goToDetail : null,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
