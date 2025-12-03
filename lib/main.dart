import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/fipe_search_screen.dart';
import 'screens/fipe_detail_screen.dart';
import 'screens/garage_screen.dart';
import 'screens/add_car_screen.dart';
import 'screens/compare_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/settings_screen.dart';
import 'package:get/get.dart';


void main() {
  runApp(const AutoInsightFipeApp());
}

class AutoInsightFipeApp extends StatelessWidget {
  const AutoInsightFipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AutoInsight FIPE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.fipeSearch: (context) => const FipeSearchScreen(),
        AppRoutes.fipeDetail: (context) => const FipeDetailScreen(),
        AppRoutes.garage: (context) => const GarageScreen(),
        AppRoutes.addCar: (context) => const AddCarScreen(),
        AppRoutes.compare: (context) => const CompareScreen(),
        AppRoutes.favorites: (context) => const FavoritesScreen(),
        AppRoutes.settings: (context) => const SettingsScreen(),
      },
    );
  }
}
