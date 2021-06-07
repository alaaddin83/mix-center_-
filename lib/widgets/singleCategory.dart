
import 'package:flutter/material.dart';
import '../screens/products_of_category.dart';

import '../config.dart';

class SingleCategoryMainScreen extends StatelessWidget {
  final Size deviceSize;
  final String imgUrl;
  final String catName;
  final catId;

  const SingleCategoryMainScreen({
    @required this.deviceSize,
    @required this.imgUrl,
    @required this.catName,
    @required this.catId,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: deviceSize.width * 0.25,
      height: deviceSize.height * 0.15,
      child: ListTile(
        dense: true,
        onTap: () {
          // print("catId:  $catId");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsOfCategory(
                  catId: catId,
                  catName: catName,
                ),
              ));
        },
        title: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: deviceSize.height * 0.1,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: new Border.all(
                color: Theme.of(context).primaryColor,
                width: 1.0,
                style: BorderStyle.solid
            ),
            image: DecorationImage(
              image: NetworkImage(path_images+"Category/"+imgUrl),
              fit: BoxFit.fill,
            ),

          ),
           // child:  FadeInImage(
           //   image:NetworkImage(path_images+"Category/"+imgUrl),
           //   fit: BoxFit.fill,
           //   placeholder: AssetImage("assets/images/mix_logo2.png"),
           // ),
        ),

        //name of category
        subtitle: Text(
          catName,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 10),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

      ),
    );
  }
}
