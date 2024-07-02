import 'package:food_delivery/data/repo/popular_product_repo.dart';
import 'package:food_delivery/models/ProductModel.dart';
import 'package:get/get.dart';
import '../data/repo/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async{
    Response response = await recommendedProductRepo.getRecommendedProductList();

    if(response.statusCode == 200){
      print('got product from recommended');
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      // print(_recommendedProductList);
      _isLoaded=true;
      update();
    }else{

    }
  }
}