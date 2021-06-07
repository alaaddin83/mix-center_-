

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix_center/providers/cart.dart';
import 'package:provider/provider.dart';

import '../config.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String img_link;

  const CartItemWidget(
  { @required this.id,
    @required this.productId,
    @required this.price,
    @required  this.quantity,
    @required this.title,
    @required this.img_link,
  }
      );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("متأكد من الحذف"),
            content: Text(' ?هل تريد حذف المنتج من السلة '),
            actions: [

              TextButton(
                child: Text('حذف'),
                onPressed: () => Navigator.of(context).pop(true),
              ),

              TextButton(
                child: Text('تراجع',style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                radius: MediaQuery.of(context).size.height* .15 / 2,
              backgroundImage:NetworkImage(path_images+"product/"+img_link),
              // child: FittedBox(
              //   child:CachedNetworkImage(
              //                 //imageUrl: path_images+"product/"+widget.proImg,
              //                 imageUrl: img_link,
              //                 placeholder:(context, url) => new Image.asset("assets/images/mix_logo2.png"),
              //                 //errorWidget: (context, url, error) => Icon(Icons.error),
              //                 fit: BoxFit.fill,
              //               ),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(5),
              //   child: FittedBox(
              //     child: Text('\$$price'),
              //   ),
              // ),
            ),
            title: Text(title),
            //subtitle: Text(' TL ${(price * quantity)}'),
            subtitle: Text(' TL ${(price)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}