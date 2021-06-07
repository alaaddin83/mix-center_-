

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mix_center/config.dart';
import '../providers/categories.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {



  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Provider.of<Categories>(context, listen: false).fetchCategories();
    Provider.of<Products>(context, listen: false).fetchAllProducts().then((value) {
      print("user  auth :$userAuthed");
    });
    // getAds();
    const duration = Duration(seconds: 3);
    new Timer(duration, () {
      Navigator.of(context).pushReplacementNamed("home");
    });
  }
  @override
  Widget build(BuildContext context) {
   // Provider.of<Products>(context).fetchAllProducts();

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: new Image(
                  image: new AssetImage(
                    "assets/images/mix_logo2.png",
                    // "images/logo_splash1.png",
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            Image(
              image: new AssetImage(
                "assets/images/aladdinapps.png",
              ),
              height: 200,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
