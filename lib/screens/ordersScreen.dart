


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item_widget.dart';
import '../providers/orders.dart';
import '../widgets/myDrawer.dart';

class OrderScreen  extends StatelessWidget {
  // static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text("طلباتي"),
        centerTitle: true,),
        drawer: MyDrawer(),
      body: FutureBuilder(
      future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders("1"),

      builder: (_, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
      } else {

      if (snapshot.error != null) {
      return Center(child: Text('An error occurred!'));
      } else {

        return Consumer<Orders>(
            builder: (ctx, orderData, child) => ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (BuildContext context, int index) => OrderItemWidget(
                orderData.orders[index],
              ),

            ),
        );
      }
      }
      }
      ),
      ),
    );
  }
}
