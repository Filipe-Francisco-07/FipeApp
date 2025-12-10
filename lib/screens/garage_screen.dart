import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/garage_controller.dart';
import '../routes/app_routes.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  late final GarageController garage;

  @override
  void initState() {
    super.initState();
    garage = Get.put(GarageController());
  }

  Future<void> _goToAddCar() async {
    final result = await Navigator.of(context).pushNamed(AppRoutes.addCar);

    if (result == true) {
      await garage.loadCars();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garagem (PHP)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              garage.loadCars();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _goToAddCar,
          ),
        ],
      ),
      body: Obx(() {
        if (garage.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final cars = garage.cars;

        return RefreshIndicator(
          onRefresh: garage.loadCars,
          child: cars.isEmpty
              ? ListView(
                  children: const [
                    SizedBox(height: 80),
                    Center(
                      child: Text('Sem carro na garagem'),
                    ),
                  ],
                )
              : ListView.separated(
                  itemCount: cars.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return ListTile(
                      leading: const Icon(Icons.directions_car),
                      title: Text(car.model),
                      subtitle: Text(
                        'Preço: R\$ ${car.price.toStringAsFixed(2)}',
                      ),
                      trailing: Text('#${car.id}'),
                    );
                  },
                ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddCar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
