import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoInsight FIPE'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Buscar na FIPE'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.fipeSearch);
              },
            ),
            ListTile(
              leading: const Icon(Icons.garage),
              title: const Text('Minha Garagem (PHP)'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.garage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.compare_arrows),
              title: const Text('Comparar Carros'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.compare);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoritos'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.favorites);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.settings);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Bem-vindo ao seu painel de carros.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: Text('Consultar preço FIPE'),
                      subtitle:
                          Text('Pesquise marcas, modelos e anos de veículos.'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.garage),
                      title: Text('Minha Garagem (PC)'),
                      subtitle: Text(
                          'Ver carros salvos via serviço PHP no seu computador.'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.compare_arrows),
                      title: Text('Comparar veículos'),
                      subtitle:
                          Text('Compare preços e informações entre modelos.'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
