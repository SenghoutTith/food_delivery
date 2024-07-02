import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/helper/route.dart';
import 'package:food_delivery/models/ProductModel.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/utiles/app_constants.dart';
import 'package:food_delivery/utiles/big_text.dart';
import 'package:food_delivery/utiles/colors.dart';
import 'package:food_delivery/utiles/new_time_km.dart';
import 'package:food_delivery/utiles/small_text.dart';
import 'package:get/get.dart';

import '../../components/navbar.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utiles/dimenstions.dart';

class PageFoodBody extends StatefulWidget {
  const PageFoodBody({super.key});

  @override
  State<PageFoodBody> createState() => _PageFoodBodyState();
}

class _PageFoodBodyState extends State<PageFoodBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimenstions.pageViewContainer220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<PopularProductController>(builder: (popularProducts) {
                    return popularProducts.isLoaded
                        ? Container(
                            height: Dimenstions.pageViewContainer320,
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: popularProducts.popularProductList.length,
                              itemBuilder: (context, position) {
                                return _buildPageItem(position,
                                    popularProducts.popularProductList[position]);
                              },
                            ),
                          )
                        : CircularProgressIndicator(
                            color: AppColors.mainColor,
                          );
                  }),

                  GetBuilder<PopularProductController>(builder: (popularProducts) {
                    return DotsIndicator(
                      dotsCount: popularProducts.popularProductList.isEmpty
                          ? 1
                          : popularProducts.popularProductList.length,
                      position: _currPageValue,
                      decorator: DotsDecorator(
                        activeColor: AppColors.mainColor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    );
                  }),

                  Container(
                    margin: EdgeInsets.only(
                      left: Dimenstions.width20,
                      top: Dimenstions.height10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BigText(title: 'Recommended'),
                        SizedBox(
                          width: Dimenstions.width5,
                        ),
                        SmallText(title: 'khmer food'),
                      ],
                    ),
                  ),

                  GetBuilder<RecommendedProductController>(builder: (recommendedProducts) {
                    return recommendedProducts.isLoaded?
                      Container(
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            recommendedProducts.recommendedProductList.length,
                            (index) => GestureDetector(
                              onTap: (){
                                Get.toNamed(RouteHelpers.getRecommendedFood(index, "home"));
                              },
                              child: Container(
                                // height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black45,
                                  boxShadow: [
                                    BoxShadow(color: Colors.black12, offset: Offset(5, 5)),
                                  ],
                                ),
                                margin: EdgeInsets.all(Dimenstions.height10),
                                padding: EdgeInsets.all(Dimenstions.height10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Dimenstions.pageViewContainer170,
                                      height: Dimenstions.pageViewContainer120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(AppConstants.baseUrl+"/uploads/"+recommendedProducts.recommendedProductList[index].img!)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimenstions.width10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          BigText(
                                            colors: Colors.white,
                                            title: recommendedProducts.recommendedProductList[index].name!,
                                            size: Dimenstions.text20,
                                          ),
                                          SizedBox(
                                            height: Dimenstions.height10,
                                          ),
                                          SmallText(
                                            title: recommendedProducts.recommendedProductList[index].description,
                                            maxLine: 3,
                                            colors: Colors.grey.shade200,
                                            textOverflow: TextOverflow.ellipsis,
                                            size: Dimenstions.text14,
                                          ),
                                          SizedBox(
                                            height: Dimenstions.height15,
                                          ),
                                          NewTimeKm(
                                            colors: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ):
                      CircularProgressIndicator(
                        color: AppColors.mainColor,
                      );
                    ;
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProductList) {
    Matrix4 matrix4 = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelpers.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimenstions.pageViewContainer220,
              margin: EdgeInsets.only(
                  left: Dimenstions.width5, right: Dimenstions.width5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(Dimenstions.radius30),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.baseUrl +
                        "/uploads/" +
                        popularProductList.img!)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimenstions.pageViewContainer100,
              margin: EdgeInsets.only(
                  bottom: Dimenstions.height20,
                  left: Dimenstions.width30,
                  right: Dimenstions.width30),
              padding: EdgeInsets.all(Dimenstions.height10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenstions.radius15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(title: popularProductList.name!),
                  SizedBox(height: Dimenstions.height5),
                  Wrap(
                    children: List.generate(
                        5,
                        (index) => Icon(
                              Icons.star,
                              color: Colors.black,
                              size: Dimenstions.icon15,
                            )),
                  ),
                  SizedBox(height: Dimenstions.height10),
                  NewTimeKm(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
