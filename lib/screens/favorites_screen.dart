import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorites_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AQUI ESTAVA O ERRO — precisa ser Get.find()
    final favorites = Get.find<FavoritesController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: Obx(() {
        if (favorites.favorites.isEmpty) {
          return const Center(child: Text("Sem favoritos"));
        }

        return ListView.builder(
          itemCount: favorites.favorites.length,
          itemBuilder: (_, index) {
            final f = favorites.favorites[index];
            final img = f["imageUrl"];

            return ListTile(
              leading: img == null
                  ? const Icon(Icons.car_rental, size: 40)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        img,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
              title: Text("${f["marca"]} ${f["modelo"]}"),
              subtitle: Text("Ano: ${f["ano"]} - Combustível: ${f["combustivel"]}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => favorites.favorites.removeAt(index),
              ),
            );
          },
        );
      }),
    );
  }
}
