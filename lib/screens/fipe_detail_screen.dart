import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/garage_controller.dart';
import '../controllers/favorites_controller.dart';
import '../models/fipe_models.dart';
import '../models/local_car.dart';
import '../services/image_service.dart';

class FipeDetailScreen extends StatefulWidget {
  const FipeDetailScreen({super.key});

  @override
  State<FipeDetailScreen> createState() => _FipeDetailScreenState();
}

class _FipeDetailScreenState extends State<FipeDetailScreen> {
  late final GarageController garage;
  late final FavoritesController favorites;
  final ImageService imageService = ImageService();

  @override
  void initState() {
    super.initState();
    garage = Get.put(GarageController());
    favorites = Get.put(FavoritesController());
  }

  double _parseFipePrice(String valor) {
    var cleaned = valor.replaceAll('R\$', '');
    cleaned = cleaned.replaceAll('.', '');
    cleaned = cleaned.replaceAll(' ', '');
    cleaned = cleaned.replaceAll(',', '.');

    return double.tryParse(cleaned) ?? 0.0;
  }

  Future<void> _addToGarage(FipeVehicleDetail detail) async {
    final price = _parseFipePrice(detail.valor);
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final car = LocalCar(
      id: id,
      model: '${detail.marca} ${detail.modelo} ${detail.anoModelo}',
      price: price,
    );

    try {
      await garage.addCar(car);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Carro adicionado à garagem (PHP) com sucesso!'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao adicionar carro à garagem: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args == null || args is! FipeVehicleDetail) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do veículo'),
        ),
        body: const Center(
          child: Text('Nenhum dado de veículo recebido.'),
        ),
      );
    }

    final FipeVehicleDetail detail = args;

    final Future<String> imageFuture = (() async {
      try {
        final real =
            await imageService.getRealCarImage(detail.marca, detail.modelo);
        return real ?? imageService.getFallbackImage(detail.modelo);
      } catch (_) {
        return imageService.getFallbackImage(detail.modelo);
      }
    })();

    return Scaffold(
      appBar: AppBar(
        title: Text(detail.modelo),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final url = snapshot.data ??
                    imageService.getFallbackImage(detail.modelo);

                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(Icons.directions_car, size: 64),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            Text(
              detail.marca,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${detail.modelo} • ${detail.anoModelo}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            Text(
              'Preço FIPE: ${detail.valor}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text('Combustível: ${detail.combustivel}'),
            Text('Código FIPE: ${detail.codigoFipe}'),
            Text('Mês de referência: ${detail.mesReferencia}'),
            const SizedBox(height: 24),

            const Text(
              'Ações',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

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
                      : const Icon(Icons.garage),
                  label: const Text('Adicionar à minha garagem (PHP)'),
                  onPressed: isSaving ? null : () => _addToGarage(detail),
                ),
              );
            }),

            const SizedBox(height: 8),

            Obx(() {
              final isFav = favorites.isFavorite(detail);

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : null,
                  ),
                  label: Text(
                    isFav ? 'Remover dos Favoritos' : 'Adicionar aos Favoritos',
                  ),
                  onPressed: () {
                    if (isFav) {
                      favorites.removeFavorite(detail);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Removido dos favoritos'),
                        ),
                      );
                    } else {
                      favorites.addFavorite(detail);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Adicionado aos favoritos'),
                        ),
                      );
                    }
                  },
                ),
              );
            }),

            const SizedBox(height: 8),
            const Text(
              '• Comparar com outro veículo – a implementar',
            ),
          ],
        ),
      ),
    );
  }
}
