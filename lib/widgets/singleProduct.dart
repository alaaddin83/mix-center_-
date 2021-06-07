import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix_center/providers/auth_user.dart';
import 'package:mix_center/providers/cart.dart';
import 'package:mix_center/providers/products.dart';
import 'package:provider/provider.dart';
import '../screens/productDetail.dart';

import '../config.dart';

class SingleProduct extends StatelessWidget {
  final prodId;
  final String prodInfo;
  final String imgPath;
  final String prodName;
  final prodNewPrice; //  فقط  عند العرض  نريد عرضه
  final prodoldPrice; //   موجود دائما  فقط في العرض يشطب
  final prodoffer; //   موجود دائما  فقط في العرض يشطب
  final isFavor; //   موجود دائما  فقط في العرض يشطب

  const SingleProduct({
    @required this.prodId,
    @required this.prodInfo,
    @required this.imgPath,
    @required this.prodName,
    @required this.prodNewPrice,
    @required this.prodoldPrice,
    @required this.prodoffer,
    @required this.isFavor,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final fav = Provider.of<Products>(context);

    double _price = int.parse(prodoffer) == 1
        ? double.parse(prodNewPrice)
        : double.parse(prodoldPrice);
    //print(" price this prod :$_price");
    return Card(
      elevation: 5.0,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //imag
                  Expanded(
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(10.0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),

                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: CachedNetworkImage(
                          imageUrl: path_images + "product/" + imgPath,
                          placeholder: (context, url) =>
                              new Image.asset("assets/images/mix_logo2.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/mix_logo2.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  //name of product
                  Container(
                    //padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      prodName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  //سعر  العرض او العادي
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      children: [
                        int.parse(prodoffer) == 1
                            ? Text(
                                "  $prodNewPrice ليرة   ",
                                style: TextStyle(
                                    color: Colors.purple,
                                    //decoration: TextDecoration.lineThrough,
                                    //fontSize: 14.0
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "   $prodoldPrice ليرة    ",
                                style: TextStyle(
                                    color: Colors.purple,
                                    //decoration: TextDecoration.lineThrough,
                                    //fontSize: 14.0
                                    fontWeight: FontWeight.bold),
                              ),
                        Expanded(
                          child: int.parse(prodoffer) == 1
                              ? RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: " $prodoldPrice ليرة  ",
                                        style: TextStyle(
                                            // color: Color(0xffC1083F),
                                            color: prodoffer == 0
                                                ? Colors.purple
                                                : Colors.red,
                                            decoration: prodoffer == 0
                                                ? ""
                                                : TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                )
                              : Text(""),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
//
                ],
              ),
              onTap: () {
                //print("pro  id  :  $prodId");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetail(
                              proName: prodName,
                              proId: prodId,
                              proImg: imgPath,
                              proPrice: prodNewPrice,
                              proInfo: prodInfo,
                              prooldPrice: prodoldPrice,
                              proOffer: prodoffer,
                            )));
              },
            ),
          ),
          //   adding to  cart
          GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 1.0),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  // Text("إضافة إلى السلة",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 12.0
                  //   ),
                  //   maxLines: 1,
                  // ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        color: Colors.red,
                        icon: isFavor==null?Icon(Icons.favorite_border_outlined)
                        :Icon(Icons.favorite),
                        onPressed: ()  {

                          //final auth =Provider.of<Auth>(context,listen: false);
                          if(userAuthed==null){
                            print("user  nul");
                            Navigator.pushNamed(context, "login");

                          }else{
                           // if(isFavor==null){
                              fav.changeFavorate(
                                  prodId: prodId,
                                  isFavor: isFavor??false
                              ).then((value) {
                                print(value);
                             } );
                              //print("favorate");
                           // }


                          }

                        }),
                  ),
                  Spacer(),
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            onTap: () {
              cart.addItem(prodId, _price, prodName, imgPath, 1, context);
            },
          ),
        ],
      ),
    );
  }
}

// IconButton(
// color: Colors.red,
// icon: Icon(Icons.favorite_border_outlined),
// onPressed: (){
// print("favorate");
// })
