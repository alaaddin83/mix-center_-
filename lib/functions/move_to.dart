


import 'package:flutter/material.dart';

moveTO(BuildContext context,Widget widget){
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget));
}