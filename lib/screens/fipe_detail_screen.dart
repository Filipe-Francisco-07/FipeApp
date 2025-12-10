import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/garage_controller.dart';
import '../controllers/favorites_controller.dart';
import '../models/fipe_models.dart';
import '../models/local_car.dart';
import '../services/unsplash_service.dart';
import '../utils/fipe_price_parser.dart';

class FipeDetailScreen extends StatefulWidget {
  const FipeDetailScreen({super.key});

  @override
  State<FipeDetailScreen> createState() => _FipeDetailScreenState();
}

class _FipeDetailScreenState extends State<FipeDetailScreen> {
  late final GarageController garage;
  late final FavoritesController favorites;

  String? imageUrl;
  bool loadingImage = true;

  @override
  void initState() {
    super.initState();

    garage = Get.find<GarageController>();
    favorites = Get.find<FavoritesController>();

    Future.microtask(_loadImage);
  }

  Future<void> _loadImage() async {
    final args = Get.arguments;
    if (args is! FipeVehicleDetail) return;

    final detail = args;
    final service = UnsplashService();

    final img = await service.searchCarImage(
      detail.marca,
      detail.modelo,
      ano: detail.anoModelo.toString(),
      combustivel: detail.combustivel,
    );

    if (!mounted) return;
    setState(() {
      imageUrl = img;
      loadingImage = false;
    });
  }

  Future<void> _addToGarage(FipeVehicleDetail detail) async {
    final price = parseFipePrice(detail.valor);

    final car = LocalCar(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      model: '${detail.marca} ${detail.modelo} ${detail.anoModelo}',
      price: price,
    );

    await garage.addCar(car);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Carro salvo na garagem (PHP)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    if (args is! FipeVehicleDetail) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes do veículo')),
        body: const Center(child: Text('Sem dados do veículo')),
      );
    }

    final detail = args;

    return Scaffold(
      appBar: AppBar(
        title: Text(detail.modelo),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: loadingImage
                    ? Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Image.network(
                        imageUrl ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(Icons.car_crash, size: 64),
                          ),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              detail.marca,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('${detail.modelo} • ${detail.anoModelo}'),
            const SizedBox(height: 12),

            Text(
              'Preço FIPE: ${detail.valor}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            Text('Combustível: ${detail.combustivel}'),
            Text('Código FIPE: ${detail.codigoFipe}'),
            Text('Mês de referência: ${detail.mesReferencia}'),

            const SizedBox(height: 24),

            const Text(
              'Ações',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.garage),
                label: const Text('Salvar na garagem (PHP)'),
                onPressed: () => _addToGarage(detail),
              ),
            ),

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
                    isFav ? 'Remover dos favoritos' : 'Favoritar',
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
                      favorites.addFavorite(detail, imageUrl);
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
          ],
        ),
      ),
    );
  }
}
