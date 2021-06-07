import 'package:flutter/material.dart';
import '../functions/lunch_url.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70.0,
              ),
              Text(
                "تمت برمجة التطبيق بواسطة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    ),
              ),
              Center(
                child: Image(
                  image: new AssetImage(
                    "assets/images/aladdinapps.png",
                  ),
                  height: 200,
                  width: 300,
                ),
              ),
              Text(
                "للمتابعة والتواصل",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    ),
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                //padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 2,
                    )),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //instagram

                    GestureDetector(
                      onTap: () {
                        launchURL('https://www.instagram.com/AladdinApps/');
                      },
                      child: Image(
                        image: AssetImage("assets/my_icons/instagram.png"),
                        height: 60,
                        width: 60,
                        fit: BoxFit.fill,
                      ),
                    ),

                    //face
                    GestureDetector(
                      onTap: () {
                        launchURL('https://www.facebook.com/AlaaddinApps/');
                      },
                      child: Image(
                        image: AssetImage("assets/my_icons/facebook.png"),
                        height: 60,
                        width: 60,
                        fit: BoxFit.fill,
                      ),
                    ),

                    //google play
                    GestureDetector(
                      onTap: () {
                        launchURL(
                            'https://play.google.com/store/apps/dev?id=5007331887298406329');
                      },
                      child: Image(
                        image: AssetImage("assets/my_icons/googel_play.png"),
                        height: 60,
                        width: 60,
                        fit: BoxFit.fill,
                      ),
                    ),

                    //whats
                    GestureDetector(
                      onTap: () {
                        launchURL('https://wa.me/+905342301623');
                      },
                      child: Image(
                        image: AssetImage("assets/my_icons/whatsapp.png"),
                        height: 60,
                        width: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
//        aladdinapps.png
    );
  }

}
