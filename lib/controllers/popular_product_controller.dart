import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repo/popular_product_repo.dart';
import 'package:food_delivery/models/ProductModel.dart';
import 'package:get/get.dart';

import '../data/repo/popular_product_repo.dart';
import '../models/CartModel.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _cartItems = 0;
  int get cartItems => _cartItems+_quantity;

  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();

    if(response.statusCode == 200){
      print('got product');
      // print('product xD ${response.body}');
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded=true;
      update();
    }else{

    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity = 0;
    _cartItems = 0;
    _cart = cart;
    var isExist = false;
    isExist = cart.existInCart(product);
    if(isExist){
      _cartItems = _cart.getQuantity(product);
      print('Quantity in cart is ${_cartItems}');
      // print("_quantity" + _quantity.toString());
    }
    print('Exist in? ${isExist}');
  }

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _cartItems = _cart.getQuantity(product);
    update();
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    }else {
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_cartItems+quantity)<0){
      Get.snackbar('Item Count', 'You need to add at least 1 quantity.',
          backgroundColor: Colors.black,
          colorText: Colors.white
      );
      if(_cartItems>0){
        quantity = -_cartItems;
        return quantity;
      }
      return 0;
    }else if((_cartItems+quantity)>20){
      Get.snackbar("Item count", "You can't add more.",
          colorText: Colors.white,
          backgroundColor: Colors.black
      );
      return 20;
    }else{
      return quantity;
    }
  }

  int get totalQuantity{
    return _cart.getTotalQuantity;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}