import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/data/repo/popular_product_repo.dart';
import 'package:food_delivery/helper/route.dart';
import 'package:food_delivery/main.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/page_food_body.dart';
import 'package:food_delivery/utiles/app_constants.dart';
import 'package:food_delivery/utiles/app_icon.dart';
import 'package:food_delivery/utiles/food_detail.dart';
import 'package:food_delivery/utiles/small_text.dart';

import '../../utiles/big_text.dart';
import '../../utiles/dimenstions.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetail({
    super.key,
    required this.pageId,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              height: Dimenstions.pageViewContainer320,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.baseUrl+"/uploads/"+product.img!),
                  ),
              ),
            ),
          ),
          Positioned(
            left: Dimenstions.width10,
            right: Dimenstions.width10,
            top: Dimenstions.height50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    if(page == "cart-page"){
                      Get.toNamed(RouteHelpers.getCartPage());
                    }else{
                      Get.toNamed(RouteHelpers.initialRoute);
                    }
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios_outlined,
                  ),
                ),
                GetBuilder<PopularProductController>(builder: (controller){
                  return Stack(
                    children:[
                      GestureDetector(
                        onTap: (){
                          if(controller.totalQuantity>=1) Get.toNamed(RouteHelpers.getCartPage());
                        },
                        child: AppIcon(icon: Icons.shopping_cart_outlined,),
                      ),
                      Get.find<PopularProductController>().totalQuantity >= 1?
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: Dimenstions.width15,
                          height: Dimenstions.height15,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(Dimenstions.width15/2)
                          ),
                          child: Center(child: SmallText(title: Get.find<PopularProductController>().totalQuantity.toString(), colors: Colors.white,)),
                        )
                      ):
                      Container()
                    ]
                  );
                }),
              ],
            ),
          ),
          Positioned(
            top: Dimenstions.pageViewContainer320 - 30,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimenstions.radius30),
                    topRight: Radius.circular(Dimenstions.radius30),
                  ),
                color: Colors.white
              ),
              child: FoodDetail(title: product.name!, description: product.description!,),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimenstions.pageViewContainer120,
          padding: EdgeInsets.all(Dimenstions.height30),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimenstions.radius30*1.2),
              topRight: Radius.circular(Dimenstions.radius30*1.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(Dimenstions.radius15)
                ),
                padding: EdgeInsets.symmetric(horizontal: Dimenstions.width20, vertical: Dimenstions.height10),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                            popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove),
                    ),
                    SizedBox(width: Dimenstions.width5,),
                    BigText(title: popularProduct.cartItems.toString()),
                    SizedBox(width: Dimenstions.width5,),
                    GestureDetector(
                        onTap: (){
                            popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Container(
                height: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(Dimenstions.radius15)
                ),
                padding: EdgeInsets.symmetric(horizontal: Dimenstions.width20, vertical: Dimenstions.height10),
                child: Center(
                  child:
                  GestureDetector(
                    onTap: (){
                      popularProduct.addItem(product);
                    },
                      child: BigText(title: '\$ ${product.price!} | Add To Cart', colors: Colors.white,),
                  ),
                ),
              )
            ],
          ),
        );
      })
    );
  }
}
