import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/helper/route.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/utiles/app_constants.dart';
import 'package:food_delivery/utiles/big_text.dart';
import 'package:food_delivery/utiles/dimenstions.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utiles/app_icon.dart';
import '../../utiles/expandable_text.dart';
import '../../utiles/small_text.dart';

class RecommandedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommandedFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimenstions.height70,
            title: Row(
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
                              if(controller.totalQuantity >=1 ) Get.toNamed(RouteHelpers.getCartPage());
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
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimenstions.height50),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimenstions.radius15),
                    topRight: Radius.circular(Dimenstions.radius15),
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: Dimenstions.height15, bottom: Dimenstions.height10),
                child: Center(child: BigText(title: product.name!, size: Dimenstions.text20,)),
            ),

            ),
            pinned: true,
            backgroundColor: CupertinoColors.inactiveGray.darkColor,
            expandedHeight: Dimenstions.pageViewContainer300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.baseUrl+"/uploads/"+product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: Dimenstions.height10, bottom: Dimenstions.height55 ,left: Dimenstions.width15, right: Dimenstions.width15),
              child: ExpandableText(text: product.description!,
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    color: CupertinoColors.inactiveGray,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimenstions.radius30),
                  topRight: Radius.circular(Dimenstions.radius30),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: Dimenstions.width20, vertical: Dimenstions.height10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                      child: AppIcon(icon: Icons.remove, color: Colors.white, backgroundColor: Colors.red),
                  ),
                  SizedBox(width: Dimenstions.width10,),
                  BigText(title: '\$ ${product.price!} x ${controller.cartItems}'),
                  SizedBox(width: Dimenstions.width10,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                      child: AppIcon(icon: Icons.add, color: Colors.white, backgroundColor: Colors.green),
                  )
                ],
              ),
            ),
            Container(
              height: Dimenstions.pageViewContainer120,
              padding: EdgeInsets.all(Dimenstions.height30),
              color: CupertinoColors.inactiveGray,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Dimenstions.width50,
                    height: Dimenstions.height50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimenstions.width20),
                        color: Colors.white
                    ),
                    child: Icon(
                      CupertinoIcons.heart_solid,
                      color: Colors.red,
                      size: Dimenstions.icon24,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
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
                        BigText(title: '\$ ${product.price!} | Add To Cart', colors: Colors.white,)
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
