
import 'package:flutter/material.dart';
import 'package:mix_center/functions/curd.dart';

class CategoryItem {
  final String cat_id;
  final String cat_name;
  final String cat_regdate;
  final String cat_image;
  final String cat_thumbnail;

  CategoryItem(this.cat_id, this.cat_name, this.cat_regdate, this.cat_image
      , this.cat_thumbnail);
}

List<CategoryItem> myCategories = [];

class Categories with ChangeNotifier {


  Future<void> fetchCategories() async {

    List arr = await getData("category/readcategory.php");

    // for (int i = 0; i < arr.length; i++) {
    //   myCategories.add({
    //     "cat_id": arr[i]["cat_id"],
    //     "cat_name": arr[i]["cat_name"],
    //     "cat_regdate": arr[i]["cat_regdate"],
    //     "cat_image": arr[i]["cat_image"],
    //     "cat_thumbnail": arr[i]["cat_thumbnail"],
    //   });
    //
    //   print(myCategories);
    // }
    for (var u in arr) {
      CategoryItem category = CategoryItem(
        u["cat_id"],
        u["cat_name"],
        u["cat_regdate"],
        u["cat_image"],
        u["cat_thumbnail"],
      );
      myCategories.add(category);
    }
    //print(" cat  no   ::::${myCategories.length}");
    notifyListeners();
  }


  CategoryItem findCategoryById(String id) {
    return myCategories.firstWhere((prod) => prod.cat_id == id);
  }

  
}