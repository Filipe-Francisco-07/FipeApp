import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/garage_controller.dart';
import '../models/local_car.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _modelController = TextEditingController();
  final _priceController = TextEditingController();

  late final GarageController garage;

  @override
  void initState() {
    super.initState();
    garage = Get.put(GarageController());
  }

  @override
  void dispose() {
    _idController.dispose();
    _modelController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _saveCar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final id = int.parse(_idController.text.trim());
    final model = _modelController.text.trim();
    final price =
        double.parse(_priceController.text.trim().replaceAll(',', '.'));

    final car = LocalCar(id: id, model: model, price: price);

    try {
      await garage.addCar(car);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Carro salvo')),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar carro $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar carro (PHP)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o ID';
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return 'ID incorreto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o modelo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  hintText: 'Ex: 53 ou 53000',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o preço';
                  }
                  final normalized = value.trim().replaceAll(',', '.');
                  if (double.tryParse(normalized) == null) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              Obx(() {
                final isSaving = garage.isSaving.value;

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: isSaving
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: const Text('Salvar'),
                    onPressed: isSaving ? null : _saveCar,
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
