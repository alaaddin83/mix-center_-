import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mix_center/providers/cart.dart';

import '../config.dart';

class OrderItem {
  final String ord_id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    // ignore: non_constant_identifier_names
    @required this.ord_id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {

  List<OrderItem> _orders = [];
  String authToken;    //   سيحصل عليها من   برفايدر  التوثيق auth
                        // لذلك يجب استخدام بروكسي بروفايدر
  String userId;

  getData(String authTok, String uId, List<OrderItem> orders) {
    authToken = authTok;
    userId = uId;
    _orders = orders;
    notifyListeners();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  //جلب الطلبات من قواعد البيانات
  Future<void> fetchAndSetOrders(String userId) async {
    final url = path_api+"orders/";
    //
    // try {
    //   final res = await http.get(url);
    //   final extractedData = json.decode(res.body) as Map<String, dynamic>;
    //   if (extractedData == null) {
    //     return;
    //   }
    //
       final List<OrderItem> loadedOrders = [];
    //   extractedData.forEach((orderId, orderData) {
    //     loadedOrders.add(
    //       OrderItem(
    //         id: orderId,
    //         amount: orderData['amount'],
    //         dateTime: DateTime.parse(orderData['dateTime']),
    //         products: (orderData['products'] as List<dynamic>)
    //             .map((item) => CartItem(
    //           id: item['id'],
    //           price: item['price'],
    //           quantity: item['quantity'],
    //           title: item['title'],
    //         ))
    //             .toList(),
    //       ),
    //     );
    //   });
    //   _orders = loadedOrders.reversed.toList();
    //   notifyListeners();
    // } catch (e) {
    //   throw e;
    // }

    //notifyListeners();
  }

  //  add order  to  db
  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    var url = path_api + "orders/insert_order.php";
    // print("orders url: $url");
    final timestamp = DateTime.now();

    var data = {
          "amount": total.toString(),
          'dateTime': timestamp.toIso8601String(),
          'userId': userId,
          'authToken': authToken,
          'products': json.encode(
            cartProduct
                .map((cartProduct) => {
              'pro_id': int.parse(cartProduct.pro_id),
              'title': cartProduct.title,
              'quantity': cartProduct.quantity,
              'price': cartProduct.price,
            }).toList(),
          ),

        };


    //print("data  in provider :  $data");
    var response = await http.post(Uri.parse(url), body: data);
    // print("response : ${json.decode(response.body)['code']}");
    // print("response : ${json.decode(response.body)['order_id']}");


    if(json.decode(response.body)['code']=="200"){
      //add  order  to   array
      _orders.insert(
        0,                 // 0  mein add  the last order in start of arry
        OrderItem(
          ord_id: json.decode(response.body)['order_id'],
          amount: total,
          dateTime: timestamp,
          products: cartProduct,
        ),
      );
    }else{
      //snackBarShow(,"تمت الإضافة بنجاح ");
     print("order   false");
    }

      notifyListeners();

  }
}