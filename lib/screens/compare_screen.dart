import 'package:flutter/material.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparar carros'),
      ),
      body: const Center(
        child: Text('Tela de comparação entre dois carros.'),
      ),
    );
  }
}
