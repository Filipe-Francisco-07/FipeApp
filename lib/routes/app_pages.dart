import 'package:get/get.dart';

import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/fipe_search_screen.dart';
import '../screens/fipe_detail_screen.dart';
import '../screens/garage_screen.dart';
import '../screens/add_car_screen.dart';
import '../screens/favorites_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.fipeSearch,
      page: () => const FipeSearchScreen(),
    ),
    GetPage(
      name: AppRoutes.fipeDetail,
      page: () => const FipeDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.garage,
      page: () => const GarageScreen(),
    ),
    GetPage(
      name: AppRoutes.addCar,
      page: () => const AddCarScreen(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesScreen(),
    ),
  ];
}
