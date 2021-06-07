



import 'package:flutter/material.dart';

SnackBar  snackBarShow(BuildContext  ctx,String  msg){

  final snack = SnackBar(
    content:  Text(msg,style: TextStyle(fontWeight: FontWeight.bold,
    fontSize: 16.0),
    textAlign: TextAlign.center,),
    duration: Duration(seconds: 2),
    backgroundColor: Theme.of(ctx).primaryColor,
    shape: StadiumBorder(),
    behavior: SnackBarBehavior.floating,

      // action: SnackBarAction(
      //   label: 'تراجع',
      //   onPressed: () {
      //     cart.removeSingleItem(pro_id);
      //   },
      // ),


  );
  ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
  ScaffoldMessenger.of(ctx).showSnackBar(snack);

}