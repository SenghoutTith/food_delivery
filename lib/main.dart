import 'package:flutter/material.dart';
import 'package:food_delivery/components/navbar.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/helper/route.dart';
import 'package:food_delivery/pages/home/page_food_body.dart';
import 'package:food_delivery/pages/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Senghout App",
          initialRoute: RouteHelpers.getSplashScreenl(),
          getPages: RouteHelpers.routes,
        );
      });
    });

  }
}


