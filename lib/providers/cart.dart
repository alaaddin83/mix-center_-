

import 'package:flutter/material.dart';
import 'package:mix_center/functions/snackbar.dart';
import 'package:mix_center/providers/auth_user.dart';
import 'package:provider/provider.dart';

class CartItem {
  final String pro_id;    //  PRO_pro_id
  final String title;
  final int quantity;
  final double price;
  final String img;

  CartItem({
    @required this.pro_id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.img,
  });
}

class Cart with ChangeNotifier {

  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  //  عدد الطلبات
  int get itemCount {
    return _items.length;
  }

  //  السعر الكلي
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }


  void addItem(String productId,double price,String title,String img,int quant,contxt) {

    if (_items.containsKey(productId)) {
      // _items.update(
      //   productId,
      //       (existingCartItem) => CartItem(
      //     pro_id: existingCartItem.pro_id,
      //     title: existingCartItem.title,
      //     price: existingCartItem.price,
      //     quantity: existingCartItem.quantity + 1,
      //   ),
      // );
      snackBarShow(contxt,"المنتج مضاف مسبقاً في السلة ");

    } else {

      final auth =Provider.of<Auth>(contxt,listen: false);

      if(auth.isAuth){
        _items.putIfAbsent(
          productId,
              () => CartItem(
            //pro_id: DateTime.now().toString(),
            pro_id:productId,
            title: title,
            quantity: quant,
            price: price,
            img:img,
          ),
        );
        snackBarShow(contxt,"تمت الإضافة بنجاح ");

      }else{
        Navigator.pushNamed(contxt, "login");
      }



    }
   // print(items);

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          pro_id: existingCartItem.pro_id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

}
