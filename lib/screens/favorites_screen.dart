import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';
import '../models/fipe_models.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController fav = Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Obx(() {
        if (fav.favorites.isEmpty) {
          return const Center(
            child: Text('Nenhum carro favoritado ainda.'),
          );
        }

        return ListView.separated(
          itemCount: fav.favorites.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final FipeVehicleDetail car = fav.favorites[index];

            final imageUrl =
                'https://source.unsplash.com/featured/?car,${Uri.encodeComponent(car.modelo)}';

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
              title: Text('${car.marca} ${car.modelo}'),
              subtitle: Text('${car.anoModelo} • ${car.valor}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  fav.removeFavorite(car);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
