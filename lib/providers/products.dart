
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mix_center/functions/curd.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class ProductItem {
  final String pro_id;
  final String pro_name;
  final String pro_image;
  final String pro_price;
  final String pro_new_price;
  final String pro_info;
  final String pro_offer;
  final String cat_id;
   final String isFavorate;

  ProductItem({this.pro_id, this.pro_name, this.pro_image, this.pro_price
    , this.pro_new_price, this.pro_info,
    this.pro_offer,
    this.cat_id,
    this.isFavorate,
  });
}

// List<ProductItem> myOfferedProducts = [];
List<ProductItem> allProducts = [];

class Products with ChangeNotifier {

  String authToken;    //   سيحصل عليها من   برفايدر  التوثيق auth
  // لذلك يجب استخدام بروكسي بروفايدر
  String userId;


  getUserData(String authTok, String uId) {
    authToken = authTok;
    userId = uId;
    notifyListeners();
  }

  Future<void> fetchAllProducts() async {


      var data = {
    "use_id": userAuthed??"",
    };
    print("user  id:  $userAuthed");
    print("data:  $data");

    List arr = await getData("product/readProductsWithFavorate.php",data);
      //print("data:  $arr");

    // for (int i = 0; i < arr.length; i++) {
    //   myCategories.add({
    //     "cat_id": arr[i]["cat_id"],
    //     "cat_name": arr[i]["cat_name"],
    //     "cat_regdate": arr[i]["cat_regdate"],
    //     "cat_image": arr[i]["cat_image"],
    //     "cat_thumbnail": arr[i]["cat_thumbnail"],
    //   });
    //
    //   print(myCategories);
    // }
    for (var u in arr) {
      ProductItem product = ProductItem(
        pro_id:u["pro_id"],
        pro_name:u["pro_name"],
        pro_image:u["pro_image"],
        pro_price:u["pro_price"],
        pro_new_price:u["pro_new_price"],
        pro_info:u["pro_info"],
        pro_offer:u["pro_offer"],
        cat_id:u["cat_id"],
        isFavorate: u["isFavorate"],
      );
      allProducts.add(product);
    }
    print("ffavvorat  in provider : ${allProducts[0].isFavorate}");
    notifyListeners();

  }


  List<ProductItem>  offeredItems()   {
    return allProducts.where((e) => e.pro_offer=="1").toList();

  }

  List<ProductItem>  findByCat_id (String cat_id)   {
    return allProducts.where((e) => e.cat_id==cat_id).toList();
  }


  List<ProductItem> findProductsWithSearch(String proName) {
    return allProducts.where((prod) => prod.pro_name.contains(proName)).toList();
   //print(" no  of pro in  search func   : ${p.length}");

  }


  Future<bool> changeFavorate({dynamic prodId, isFavor}) async {

    //_setFavValue(!isFavor);

    var data = {
      "use_id": userAuthed??"",
      "prodId": prodId,
      //"isFavor": isFavor??true,
    };
    print(data);
    var url;
    if(!isFavor){
       url= path_api + "favorite/insert_favorite.php";
    }else{
       url = path_api + "favorite/delete_favorite.php";
    }
    print(data);

    var response = await http.post(Uri.parse(url), body: data);
    print(response);
    if(json.decode(response.body)['code']=="200"){
      //fetchAllProducts();
      //favIcon= Icon(Icons.favorite) ;
      fetchAllProducts();
      return true;
    }

    return false;

  }

  void _setFavValue(bool newValue) {
    bool _favNew = newValue;
    notifyListeners();
  }

  // Future<void> toggleFavoriteStatus(String token, String userId) async {
  //   // final oldStatus = isFavorite;
  //   // isFavorite = !isFavorite;
  //   // notifyListeners();
  //
  //   final url = 'https://shop-e66d0.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
  //   try {
  //     final res = await http.put(url, body: json.encode(isFavorite));
  //     if (res.statusCode >= 400) {
  //       _setFavValue(oldStatus);
  //     }
  //   } catch (e) {
  //     _setFavValue(oldStatus);
  //   }
  // }


  List<Products> get favoritesItems {
    //return _items.where((prodItem) => prodItem.isFavorite).toList();
  }
}