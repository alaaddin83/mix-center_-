

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;

import '../config.dart';

class ProductDetail extends StatefulWidget {
  final String proName;
  final String proImg;
  final String proInfo;
  final String proOffer;
  final  proId;
  final  proPrice;
  final  prooldPrice;

  const ProductDetail({
    @required this.proName,
    @required this.proImg,
    @required this.proId,
    @required this.proPrice,  //  for offer
    @required this.proInfo,
    @required this.proOffer,
    @required this.prooldPrice,
  }) ;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    var dz=MediaQuery.of(context).size;
    final cart = Provider.of<Cart>(context);

    return Scaffold(

      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //img  of product
                    Container(
                      height: dz.height*0.40,
                      width: double.infinity,
                      child: Hero(
                        tag: widget.proId,
                        child:CachedNetworkImage(
                          imageUrl: path_images+"product/"+widget.proImg,
                          placeholder:(context, url) => new Image.asset("assets/images/mix_logo2.png"),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.fill,
                        ),
                        // Image.network(widget.proImg,
                        //     fit: BoxFit.fill),

                      ),
                    ), // end img
                    SizedBox(height: 5),

                    //prod   name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        ' ${widget.proName}',
                        style: TextStyle(
                          //color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow:TextOverflow.ellipsis ,

                      ),
                    ),

                    //   Price
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          //  عرض السعر الحالي سواء يوجد عرض ام لا
                          int.parse(widget.proOffer)==1? Text(
                            ' ${widget.proPrice}  ليرة',
                            style: TextStyle(
                              //color: Color(0xffC1083F),
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.right,
                          )
                              :Text(
                            ' ${widget.prooldPrice}  ليرة ',
                            style: TextStyle(
                              //color: Color(0xffC1083F),
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.right,
                          ) ,

                          Text("       "),
                          //  عرض فقط في حالة هناك عرض
                          int.parse(widget.proOffer)!=1? Text(" "):Text(
                            ' ${widget.prooldPrice} ليرة',
                            style: TextStyle(
                                color: Color(0xffC1083F),
                                // color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough
                            ),
                            textAlign: TextAlign.right,
                          ),

                          // widget.prooldPrice==0||widget.prooldPrice==null? Text(
                          //   ' ${widget.prooldPrice} TL',
                          //   style: TextStyle(
                          //     color: Color(0xffC1083F),
                          //     // color: Colors.yellow,
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 16,
                          //     decoration: TextDecoration.lineThrough
                          //   ),
                          //   textAlign: TextAlign.right,
                          // ):Text(""),
                        ],
                      ),
                    ),

                    //لكمية المطلوبة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              child: GestureDetector(
                                 onTap: (){
                                   add();
                                 },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            )
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          _quantity.toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        ClipOval(
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              child: GestureDetector(
                                onTap: subtract,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            )
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    //descreption  //  info
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      child: Text(
                        widget.proInfo,
                        //textAlign: TextAlign.center,
                        //softWrap: true,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
                Container(
                  child: Positioned(
                    top: 10.0,
                    right: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                      color: Colors.purple,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },

                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: dz.height*0.08,
        //color: Colors.purple,
        child: ElevatedButton(
          onPressed: () {
            var price=widget.proPrice==0||widget.proPrice==null?widget.prooldPrice:widget.proPrice;
            double _price=double.parse(price);

            cart.addItem(widget.proId, _price, widget.proName,widget.proImg,_quantity,context);

          },
          child: Text(
            'إضافة إلى السلة'.toUpperCase(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                //color: Colors.black
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(10),
                 topRight: Radius.circular(10),
               ),

            ),
          ),
        ),
      ),
    );
  }
  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        //print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
     // print(_quantity);
    });
  }
}
