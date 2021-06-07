

import 'package:flutter/material.dart';
import 'package:mix_center/functions/snackbar.dart';
import 'package:mix_center/providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/myDrawer.dart';
import '../widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    var  dz=MediaQuery.of(context).size;
    final cart = Provider.of<Cart>(context);

    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        appBar: AppBar(
          title: Text(' سلتي '),
          centerTitle: true,
        ),
        drawer: MyDrawer(),

       body: Directionality(
         textDirection: TextDirection.rtl,
         child: Container(
           height: dz.height,
           width: dz.width,
           child: cart.items.length>0
               ?ListView.builder(
               itemCount: cart.items.length,
               itemBuilder: (BuildContext context, int index) {
                 print("id : ${cart.items.keys.toList()[index]}");
                 print("pro id : ${cart.items.values.toList()[index].pro_id}");
                 print("pro price : ${cart.items.values.toList()[index].price}");
                 return CartItemWidget(
                     id: cart.items.keys.toList()[index],
                     // productId: cart.items[index].id,
                     productId: cart.items.values.toList()[index].pro_id,
                     price: cart.items.values.toList()[index].price,
                     quantity:cart.items.values.toList()[index].quantity,
                      title:cart.items.values.toList()[index].title,
                      img_link:cart.items.values.toList()[index].img
                    );

               }

           )
               : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                     'لايوجد محتوى حالياً',
                     style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                         ),
               ),
                    Text(
                      'يرجى المحاولة لاحقاً',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
           )
         ) ,
       ),

        bottomNavigationBar: Container(
          height: dz.height*0.08,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              // color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[100],
                    spreadRadius: 1.0,
                    blurRadius: 1.0,
                    offset: Offset(0, 1)),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //send order
              OrderButton(cart: cart,),

              Expanded(child: Text("")),

              //bill   value
              Padding(
                padding: const EdgeInsets.only(left: 1.0),
                child: Text(
                  ' قيمة الفاتورة ',
                  // 'TL قيمة الفاتورة = ${getTotallPrice(myArray)}',
                  style: TextStyle(
                      fontSize: 12,
                      //color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Chip(
                  label: Text(
                    '  TL  ${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color:
                      Theme.of(context).primaryTextTheme.headline6.color,
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),


            ],
          ),

        ),
      ),
    );
  }

}

class OrderButton extends StatefulWidget {
  final Cart cart;
  const OrderButton({
    @required this.cart,
  });

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {

  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: ElevatedButton(
        onPressed: () async {
          if(widget.cart.totalAmount <= 0 || _isLoading){
            // null;
            snackBarShow(context,"لايوجد منتجات لارسال طلب");
            // print("order   dont send ");
          }else{
            setState(() {
              _isLoading = true;
            });
            await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount
            );
            setState(() {
              _isLoading = false;
            });

            widget.cart.clear();

            snackBarShow(context,"تم ارسال طلبك بنجاح");

            //print("send done ");
          }

        },

        child:_isLoading ? CircularProgressIndicator()
            :  Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Text(
              "ارسال الطلب",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),

      ),
    );
  }

}


