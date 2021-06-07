import 'package:flutter/material.dart';
import 'package:mix_center/functions/curd.dart';

class AdItem {
  final String ad_id;
  final String ad_img_link;
  final String ad_active;
  final String ad_regdate;

  AdItem(this.ad_id, this.ad_img_link, this.ad_active, this.ad_regdate);
}

List<AdItem> addsArray = [];

class Adds with ChangeNotifier {

  Future<List<AdItem>>   getAdds() async {
    List arr = await getData("ads/read_ads.php");
    //for (int i = 0; i < arr.length; i++) {
    // addsArray=[];
    clear();
    for (var u in arr) {
      AdItem imgAd = AdItem(
        u["ad_id"],
        u["ad_img_link"],
        u["ad_active"],
        u["ad_regdate"],
      );
      addsArray.add(imgAd);
    }

    // print("  getdata   fun  res: ${addsArray}");

    return addsArray;
  }

  void clear() {
    addsArray = [];
    notifyListeners();
  }

}