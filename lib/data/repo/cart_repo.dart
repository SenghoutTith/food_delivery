// import 'dart:convert';

import 'dart:convert';

import 'package:food_delivery/utiles/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/CartModel.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addCartList(List<CartModel> cartList){


      // sharedPreferences.remove('Cart-list');
      // sharedPreferences.remove(AppConstants.cartHistory);

      var time = DateTime.now().toString();
      cart=[];

      cartList.forEach((element) {
        element.time = time;
        return cart.add(jsonEncode(element));
      });

      // or this
      // cartList.forEach((element) => cart.add(jsonEncode(element)));

      sharedPreferences.setStringList('Cart-list', cart);
      getCartList();
  }

  List<CartModel> getCartList(){
    
    List<String> carts = [];
    
    if(sharedPreferences.containsKey("Cart-list")){
      carts = sharedPreferences.getStringList("Cart-list")!;
    }

    List<CartModel> cartList = [];
    
    // carts.forEach((element) {
    //   cartList.add(CartModel.fromJson(jsonDecode(element)));
    // });

    // or this
    carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.cartHistory)){
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.cartHistory)!;
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    return cartListHistory;
  }

  void addToHistory(){

    if(sharedPreferences.containsKey(AppConstants.cartHistory)){
      cartHistory = sharedPreferences.getStringList(AppConstants.cartHistory)!;
    }

    for(int i=0; i<cart.length; i++){
      cartHistory.add(cart[i]);
    }

    removeCart();
    print("Cart history , ${cartHistory}");
    sharedPreferences.setStringList(AppConstants.cartHistory, cartHistory);
    print('AFTER cart history length list:' + getCartHistoryList().length.toString());
  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove("Cart-list");
  }
}
