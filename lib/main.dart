import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_routes.dart';
import 'routes/app_pages.dart';

import 'controllers/garage_controller.dart';
import 'controllers/favorites_controller.dart';

void main() {
  runApp(const AutoInsightFipeApp());
}

class AutoInsightFipeApp extends StatelessWidget {
  const AutoInsightFipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Consulta FIPE',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,

      initialBinding: BindingsBuilder(() {
        Get.put<GarageController>(GarageController(), permanent: true);
        Get.put<FavoritesController>(FavoritesController(), permanent: true);
      }),
    );
  }
}
