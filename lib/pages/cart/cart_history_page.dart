import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/utiles/app_constants.dart';
import 'package:food_delivery/utiles/app_icon.dart';
import 'package:food_delivery/utiles/big_text.dart';
import 'package:food_delivery/utiles/colors.dart';
import 'package:food_delivery/utiles/dimenstions.dart';
import 'package:food_delivery/utiles/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {

     var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();

     Map<String, int> cartItemsPerOrder =  Map();

     var listCounter = 0;

     for(int i=0; i<getCartHistoryList.length; i++){
       if(cartItemsPerOrder.containsKey(getCartHistoryList[i]!.time)){
         cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => value++);
       }else{
         cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
       }
     }

     List<int> cartOrderTimeToList(){
        return cartItemsPerOrder.entries.map((e) => e.value).toList();
     }

     List<int> itemsPerOrder = cartOrderTimeToList();

     print(cartItemsPerOrder);


    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            height: Dimenstions.height100,
            width: double.infinity,
            padding: EdgeInsets.only(top: Dimenstions.height50, left: Dimenstions.width15, right: Dimenstions.width15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(title: 'Cart History', colors: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimenstions.height20,
                left: Dimenstions.width20,
                right: Dimenstions.width20
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for(int i=0; i<itemsPerOrder.length; i++)
                        Container(
                          margin: EdgeInsets.only(bottom: Dimenstions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ((){
                                DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
                                var inputDate = DateTime.parse(parseDate.toString());
                                var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                                var outputDate = outputFormat.format(inputDate);
                                return BigText(title: outputDate);
                              }()),

                              SizedBox(height: Dimenstions.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPerOrder[i], (index) {
                                        if(listCounter<getCartHistoryList.length){
                                          listCounter++;
                                        }
                                        return index<=2?Container(
                                          height: Dimenstions.height70,
                                          width: Dimenstions.width70,
                                          margin: EdgeInsets.only(right: Dimenstions.width10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      '${AppConstants.baseUrl}/${AppConstants.uploadUrl}/${getCartHistoryList[listCounter-1].img!}'
                                                  )
                                              )
                                          ),
                                        ):Container();
                                      })
                                  ),
                                  Container(
                                    height: Dimenstions.height70,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(title: "Total"),
                                        BigText(title: itemsPerOrder[i].toString() + " Items" ),
                                        Container(
                                          padding: EdgeInsets.all(Dimenstions.width5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimenstions.radius15/15),
                                            border: Border.all(width: 1, color: AppColors.mainColor),
                                          ),
                                          child: SmallText(title: 'One more',),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ]
                  )
              )
            ),
          )
        ],
      ),
    );
  }
}
