import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/helper/route.dart';
import 'package:food_delivery/utiles/big_text.dart';
import 'package:food_delivery/utiles/colors.dart';
import 'package:food_delivery/utiles/dimenstions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState(){
    super.initState();
    _loadResource();
    controller = new AnimationController(vsync: this, duration: Duration(seconds: 1))..forward();
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    Timer(Duration(seconds: 1), ()=>Get.offNamed(RouteHelpers.getInitialRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
                child: Image.asset('images/img.png', width: Dimenstions.pageViewContainer320,),
            ),
            SizedBox(height: Dimenstions.height20,),
            BigText(title: "Senghout App", colors: Colors.white, size: Dimenstions.text20,),
            Divider(
                color: Colors.white,
                indent: Dimenstions.width58,
                endIndent: Dimenstions.width58,
              ),
            Divider(
              color: Colors.white,
              indent: Dimenstions.width58 * 2,
              endIndent: Dimenstions.width58 * 2,
            ),
            Divider(
              color: Colors.white,
              indent: Dimenstions.width58 * 3,
              endIndent: Dimenstions.width58 * 3,
            ),
          ],
        ),
      ),
    );
  }
}
