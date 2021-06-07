import 'dart:convert';

import '../config.dart';
import 'package:http/http.dart' as http;

Future<List> getData(String urlPage,[data]) async {
  String url = path_api + urlPage;
  var respone;


  if (data != null) {
    respone = await http.post(Uri.parse(url), body: data);
  } else {
    respone = await http.post(Uri.parse(url));
  }

  if (json.decode(respone.body)["code"] == "200") {
    List arr = (json.decode(respone.body)["message"]);
    print("url  is: $url");
    //print("data  is: $arr");
    return arr;
  } else {
    return null;
  }
}


