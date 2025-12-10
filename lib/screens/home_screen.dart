import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _goTo(String route) {
    Get.toNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta FIPE'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF607D8B)),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.of(context).pop();
                if (Get.currentRoute != AppRoutes.home) {
                  Get.offAllNamed(AppRoutes.home);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoritos'),
              onTap: () {
                Navigator.of(context).pop();
                _goTo(AppRoutes.favorites);
              },
            ),
            const Divider(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Bem-vindo à consulta FIPE!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: ListView(
                children: [
                  _HomeOptionCard(
                    icon: Icons.search,
                    title: 'Consultar preço FIPE',
                    subtitle: 'Pesquisar Marca/Modelo/Ano do veículo.',
                    onTap: () => _goTo(AppRoutes.fipeSearch),
                  ),
                  _HomeOptionCard(
                    icon: Icons.computer,
                    title: 'Garagem (PHP)',
                    subtitle:
                        'Ver carros salvos localmente pelo PHP.',
                    onTap: () => _goTo(AppRoutes.garage),
                  ),
                  _HomeOptionCard(
                    icon: Icons.favorite,
                    title: 'Favoritos',
                    subtitle: 'Ver veículos favoritados.',
                    onTap: () => _goTo(AppRoutes.favorites),
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

class _HomeOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HomeOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
