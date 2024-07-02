import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/helper/route.dart';
import 'package:food_delivery/utiles/app_constants.dart';
import 'package:food_delivery/utiles/app_icon.dart';
import 'package:food_delivery/utiles/big_text.dart';
import 'package:food_delivery/utiles/dimenstions.dart';
import 'package:food_delivery/utiles/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimenstions.height20*3,
              left: Dimenstions.width20,
              right: Dimenstions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelpers.getInitialRoute());
                    },
                      child: AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelpers.getInitialRoute());
                        },
                          child: AppIcon(icon: Icons.home_outlined),
                      ),
                      SizedBox(width: Dimenstions.width10,),
                      AppIcon(icon: Icons.shopping_cart_outlined),
                    ],
                  ),
                ],
              )
          ),
          Positioned(
            top: Dimenstions.height20*6,
              left: Dimenstions.width20,
              right: Dimenstions.width20,
              bottom: 0,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (controller){
                  return ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.getItems.length,
                      itemBuilder: (context, index){
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimenstions.radius15),
                              boxShadow: [BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 2,
                                  offset: Offset(2,2)
                              )]
                          ),
                          child: Row(
                            children: [
                              // 1st container
                              GestureDetector(
                                onTap: (){
                                  var popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(controller.getItems[index].product!);
                                  if(popularIndex >= 0){
                                    Get.toNamed(RouteHelpers.getPopularFood(popularIndex, "cart-page"));
                                  }else{
                                    var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(controller.getItems[index].product!);
                                    Get.toNamed(RouteHelpers.getRecommendedFood(recommendedIndex, 'cart-page'));
                                  }
                                },
                                child: Container(
                                  width: Dimenstions.pageViewContainer170,
                                  height: Dimenstions.pageViewContainer120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimenstions.radius15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(AppConstants.baseUrl+"/uploads/"+controller.getItems[index].img!)
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimenstions.width10,),
                              // 2nd container
                              Expanded(
                                child: Container(
                                  height: Dimenstions.pageViewContainer120,
                                  padding: EdgeInsets.only(right: Dimenstions.width10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(title: controller.getItems[index].name!, colors: Colors.white,),
                                      SmallText(title: 'spicy', colors: Colors.white,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(title: "\$ ${controller.getItems[index].price!.toString()}", colors: Colors.white,),
                                          Container(
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    controller.addItem(controller.getItems[index].product!, -1);
                                                  },
                                                  child: Icon(Icons.remove, color: Colors.red,),
                                                ),
                                                SizedBox(width: Dimenstions.width5,),
                                                // BigText(title: popularProduct.cartItems.toString()),
                                                Container(
                                                  padding: EdgeInsets.all(Dimenstions.height5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius: BorderRadius.circular(Dimenstions.radius15),
                                                  ),
                                                  child: BigText(title: controller.getItems[index].quantity!.toString()),
                                                ),
                                                SizedBox(width: Dimenstions.width5,),
                                                GestureDetector(
                                                  onTap: (){
                                                    controller.addItem(controller.getItems[index].product!, 1);
                                                  },
                                                  child: Icon(Icons.add, color: Colors.green,),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                      });
                },),
              ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimenstions.pageViewContainer120,
              padding: EdgeInsets.all(Dimenstions.height30),
              color: CupertinoColors.inactiveGray,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimenstions.width10),
                    // width: Dimenstions.width50,
                    height: Dimenstions.height50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimenstions.width20),
                        color: Colors.white
                    ),
                    child: Center(child: BigText(title: "\$"+controller.totalAmount.toString())),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addToHistory();
                      // controller.addItem(product);
                    },
                    child: Container(
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(Dimenstions.radius15)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: Dimenstions.width20, vertical: Dimenstions.height10),
                      child: Center(
                        child:
                        BigText(title: 'Checkout', colors: Colors.white,)
                        ,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
