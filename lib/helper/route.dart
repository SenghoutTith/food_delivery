import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import '../pages/food/recommanded_food_detail.dart';

class RouteHelpers{
  static const String splashScreen = '/splash-screen';
  static const String initialRoute = '/';
  static const String popularFoodDetail = '/popular-food-detail';
  static const String recommendedFoodDetail = '/recommended-food-detail';
  static const String cartPage = '/cart-page';

  static String getSplashScreenl() => "$splashScreen";
  static String getInitialRoute() => "$initialRoute";
  static String getPopularFood(int pageId, String page) => "$popularFoodDetail?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page) => "$recommendedFoodDetail?pageId=$pageId&page=$page";
  static String getCartPage() => "$cartPage";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),

    GetPage(name: initialRoute, page: () => HomePage()),

    GetPage(name: popularFoodDetail, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
    }),

    GetPage(name: recommendedFoodDetail, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommandedFoodDetail(pageId: int.parse(pageId!), page: page!);
    }) ,

    GetPage(name: cartPage, page: () => CartPage())
  ];
}