

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/products.dart';
import '../widgets/myDrawer.dart';
import '../widgets/singleProduct.dart';
import 'package:provider/provider.dart';


class ProductsOfCategory extends StatelessWidget {
  final catId;
  final String catName;

  const ProductsOfCategory({
    this.catId,
    this.catName}) ;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context,listen: false).findByCat_id(catId);
    products.shuffle();

    // print("no  products in shufle : ${products.length}");
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        appBar: AppBar(
          title: Text(catName),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward,
                color: Colors.white,
                size: 30.0,), onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        drawer: MyDrawer(),

        body: RawScrollbar (
          thumbColor: Colors.purple,
          radius: Radius.circular(15),
          isAlwaysShown: true,
          thickness: 4.0,
          child: Scrollbar(
            child: Directionality(
              textDirection: TextDirection.rtl,
                child: products.length>0
                    ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //crossAxisSpacing: 2.0
                      childAspectRatio: 2/2.6,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {

                      return SingleProduct(
                        prodId: products[index].pro_id,
                        imgPath: products[index].pro_image,
                        prodName: products[index].pro_name,
                        prodInfo: products[index].pro_info,
                        prodNewPrice: products[index].pro_new_price,
                        prodoldPrice: products[index].pro_price,
                        prodoffer: products[index].pro_offer,
                      );

                      // ));
                    },
                  ),
                )
                    : Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.purple),
                  strokeWidth: 5,
                ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}


