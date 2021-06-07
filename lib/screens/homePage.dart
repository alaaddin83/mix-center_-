import 'package:cached_network_image/cached_network_image.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix_center/functions/move_to.dart';
import 'package:mix_center/functions/snackbar.dart';
import 'package:mix_center/providers/index_of_image.dart';
import 'package:mix_center/screens/search_page.dart';
import 'package:mix_center/widgets/singleProduct.dart';
import '../widgets/showAlertDialog.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/categories.dart';
import '../providers/products.dart';
import '../screens/cartScreen.dart';
import '../widgets/badge.dart';
import '../widgets/singleCategory.dart';
import '../providers/adds.dart' show AdItem, Adds, addsArray;
import '../config.dart';
import '../widgets/myDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<AdItem>> futureImage;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

int n=0;
void AwesomeDialog(String title, String body) {
    showDialogAll(context,title,body);
  }

  initialMessage()async{
   var msg= await FirebaseMessaging.instance.getInitialMessage();
   if(msg !=null){  //  يعني تم الضغط على الاشعار
     Navigator.of(context).pushNamed("home");
   }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureImage=null;
    futureImage =Provider.of<Adds>(context, listen: false).getAdds();


    FirebaseMessaging.onMessage.listen((event) {
      // print("============================");
      // print(event.from);  //  message text
      // print("============================");
       AwesomeDialog(event.notification.title,event.notification.body);

    });
    //app  in background
    //FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //  Navigator.of(context).pushNamed(CartScreen.routeName);
    // });

    // done when app terminated
    initialMessage();

  }
  @override
  Widget build(BuildContext context) {
    var ds = MediaQuery.of(context).size;
    final prod=Provider.of<Products>(context, listen: false).offeredItems();
    final indx=Provider.of<Index>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(' mix center '),
          centerTitle: true,
          actions: [
            Consumer<Cart>(
              builder: (_, cart, ch)=>Badge(
                child: ch,
                value: cart.itemCount.toString(),
                 ) ,
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>moveTO(context, SearchScreen()),
                  //Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          ],
        ),

        //          ConstrainedBox
          //     constraints: BoxConstraints(),
        drawer: MyDrawer(),
        body: WillPopScope(
          onWillPop: _onWillPop,
          //  or  CupertinoScrollbar
          child: RawScrollbar(
            thumbColor: Colors.purple,
            radius: Radius.circular(15),
            isAlwaysShown: true,
            thickness: 4.0,
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //image slide
                      FutureBuilder(
                          future: futureImage,
                          builder: (_, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              // return Center(child: CircularProgressIndicator());
                              return Container();
                            } else {
                              return CarouselSlider.builder(
                                  itemCount: snapshot.data.length,
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    aspectRatio: 2.0,
                                    enlargeCenterPage: true,
                                    viewportFraction: 1.0,
                                    initialPage: 0,
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    onPageChanged: (index, reason) {
                                      //  setState(() {
                                      //    currentsliderindex = index;
                                      // //   //_currentKeyword = keywords[_currentPage];
                                      //  });
                                      indx.indexOfImage(index);
                                    },
                                    autoPlayInterval: Duration(seconds: 4),
                                    autoPlayAnimationDuration:
                                    const Duration(milliseconds: 300),
                                    pauseAutoPlayOnTouch: true,
                                  ),
                                  itemBuilder: (BuildContext context, int index, int realIndex) {
                                    String imgPath = snapshot.data[index].ad_img_link;
                                    // print("img   path   :   ${path_images+"adds/"+imgPath}");
                                    // print("no of ads   :   ${snapshot.data.length}");
                                    return _adImageWidget(imgPath);

                                  }
                              );

                            }
                          }),

                      // //  index of  img
                      Container(
                        height: ds.height * 0.03,
                        child: addsArray.length > 1
                            ? new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < addsArray.length; i++)
                              Container(
                                height: 6,
                                width: i == indx.currentsliderindex ? 10 : 4,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: i == indx.currentsliderindex
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey,
                                ),
                              ),
                          ],
                        )
                            : Container(
                          height: 1.0,
                        ),
                      ),

                      //   categuray كلمةالاقسام
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                        child: Text(
                          "الأقسام",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),

                      //  container  list of  category


                      //addsArray.length>0?
                      Container(
                        height: ds.height * 0.17,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:myCategories.length,

                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {

                            if (myCategories.length == 0) {
                              CircularProgressIndicator();
                            }
                            return SingleCategoryMainScreen(
                                deviceSize: ds,
                                imgUrl: myCategories[index].cat_thumbnail,
                                catName: myCategories[index].cat_name,
                                catId: myCategories[index].cat_id);
                          },

                        ),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      //  أهم العروض
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 15.0),
                        child: Text(
                          "أحدث العروض",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),

                      //  container  list of  offers
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.35,
                      //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      //
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: prod.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //      if (prod.length > 0) {
                      //        return SingleProduct(
                      //          imgPath: prod[index].pro_image,
                      //          prodName: prod[index].pro_name,
                      //          prodNewPrice: prod[index].pro_new_price,
                      //          prodId: prod[index].pro_id,
                      //          prodInfo: prod[index].pro_info,
                      //          prodoldPrice: prod[index].pro_price,
                      //          prodoffer: prod[index].pro_offer,
                      //        );
                      //      } else {
                      //        return Center(
                      //          child: CircularProgressIndicator(),
                      //        );
                      //      }
                      //     },
                      //     ),
                      // ),


                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2/2.65,
                          crossAxisSpacing:1.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: prod.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),

                        itemBuilder: (BuildContext context, int index) {
                          if (prod.length > 0) {
                            //prod.shuffle();
                            return SingleProduct(
                              imgPath: prod[index].pro_image,
                              prodName: prod[index].pro_name,
                              prodNewPrice: prod[index].pro_new_price,
                              prodId: prod[index].pro_id,
                              prodInfo: prod[index].pro_info,
                              prodoldPrice: prod[index].pro_price,
                              prodoffer: prod[index].pro_offer,
                            );

                            // return Container(height: 100.0,);
                          }else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },

                      ),

                      // ListView.builder(
                      //   // scrollDirection: Axis.horizontal,
                      //   itemCount: prod.length,
                      //   shrinkWrap: true,
                      //   physics: ScrollPhysics(),
                      //   itemBuilder: (BuildContext context, int index) {
                      //     if (prod.length > 0) {
                      //       return SingleProduct(
                      //         imgPath: prod[index].pro_image,
                      //         prodName: prod[index].pro_name,
                      //         prodNewPrice: prod[index].pro_new_price,
                      //         prodId: prod[index].pro_id,
                      //         prodInfo: prod[index].pro_info,
                      //         prodoldPrice: prod[index].pro_price,
                      //         prodoffer: prod[index].pro_offer,
                      //       );
                      //     } else {
                      //       return Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     }
                      //   },
                      // ),
                      SizedBox(
                        height: 70.0,
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        )

      ),
    );
  }

  Widget _adImageWidget(String imgPath) {
    return Builder(builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        child: CachedNetworkImage(
          imageUrl: path_images + "adds/" + imgPath,
          placeholder:(context, url) => new Image.asset("assets/images/mix_logo2.png"),
          errorWidget: (context, url, error) => Image.asset("assets/images/mix_logo2.png"),
          fit: BoxFit.fill,
        ),
      );
    });
  }

  //handle   back btn
  DateTime backbtnpressedTime;
  Future<bool> _onWillPop() async {
    DateTime currenttime = DateTime.now();
    bool backbtn = backbtnpressedTime == null ||
        currenttime.difference(backbtnpressedTime) > Duration(seconds: 4);
    if (backbtn) {
      backbtnpressedTime = currenttime;
      // Fluttertoast.showToast(
      //   msg: 'للخروج اضغط على زر الرجوع مرة أخرى',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: kMainColor,
      //   textColor: Colors.white,
      //   fontSize: 20.0,
      // );
      snackBarShow(context,"للخروج اضغط على زر الرجوع مرة أخرى");


      return false;
    }
    return true;
  }
}


