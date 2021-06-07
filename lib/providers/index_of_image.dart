


import 'package:flutter/material.dart';

class Index with ChangeNotifier {

  int currentsliderindex = 0;


  void indexOfImage(int indx) {
    currentsliderindex=indx;
    notifyListeners();
  }



}