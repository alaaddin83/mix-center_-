import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mix_center/config.dart';
import 'package:mix_center/functions/cachedHelper.dart';
import 'package:mix_center/providers/adds.dart';
import 'package:mix_center/providers/auth_user.dart';
import 'package:mix_center/providers/cart.dart';
import 'package:mix_center/providers/categories.dart';
import 'package:mix_center/providers/index_of_image.dart';
import 'package:mix_center/providers/orders.dart';
import 'package:mix_center/providers/products.dart';
import 'package:mix_center/screens/about_app.dart';
import 'package:mix_center/screens/acount/login.dart';
import 'package:mix_center/screens/cartScreen.dart';
import 'package:mix_center/screens/homePage.dart';
import 'package:provider/provider.dart';

import 'screens/Splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //  for null
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("usersApp");

  await CacheHelper.init();
  userAuthed = CacheHelper.getData(key: 'use_id');
  print("userAuthed  is  : $userAuthed");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Adds()),
        ChangeNotifierProvider.value(value: Categories()),
        //ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Index()),
        //ChangeNotifierProvider.value(value: Orders()),

        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          //  update  the orders class provider every time make anew something in Auth
          update: (ctx, authValue, previousOrders) => previousOrders
            ..getData(
              authValue.token ,
             authValue.userId,
             previousOrders == null ? null : previousOrders.orders,
            ),

        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          //  update  the Products class provider every time make anew something in Auth
          update: (ctx, authValue, previousProducts) {

           return previousProducts
              ..getUserData(
                authValue.token,
                authValue.userId,
              )..userId;
          }

        ),

      ],

      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.orangeAccent,
            canvasColor: Colors.grey.shade200,
            scaffoldBackgroundColor: Color(0xffF5F5F5),
            fontFamily: "Cairo",
          appBarTheme: AppBarTheme(
            centerTitle: true,
            brightness: Brightness.dark
          ),
        ),

        home: SplashScreen(),

        routes: {
          "home": (context) => HomePage(),
          //"homeS": (context) => HomeScreen(),
          "login": (context) => Login(),
          "aboutMe": (context) => AboutMe(),
          CartScreen.routeName: (_) => CartScreen(),
          //OrderScreen.routeName: (_) => OrderScreen(),

          //"ProductsCategory": (context) => ProductsCategory(),
        },
      ),
    );
  }
}
