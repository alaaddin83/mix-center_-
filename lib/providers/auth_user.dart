

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mix_center/config.dart';
import 'package:mix_center/functions/cachedHelper.dart';
import 'package:mix_center/widgets/showAlertDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import 'package:http/http.dart' as http;



enum AuthMode { Signup, Login }

class Auth with ChangeNotifier {
  String user_id;

  String _token;
 // DateTime _expiryTime;
  String userName;
  String userMobile;
    //   getter  return _token
  String  get token  {
    if (_token != null)
      return _token;
    else
      return null;
  }

  String get userId {
    return user_id;
  }


  bool get isAuth   {
    getDataFromSharedPref();
  print(" token in is_auth is : $_token");
    if(_token == null) {
     // print(" token in ia auth is : $_token");
      return false;
    }else{
      return true;
    }
    notifyListeners();
  }

//   signup
 Future<bool> signUp(String  phone,String  pwd,String  userName,BuildContext ctxt,String tokenn) async {
    var url = path_api + "users/insert_user.php";
    //print("login url: $url");
    var data = {
      "mobile": phone,
      "password": pwd,
      'username': userName,
      "token": tokenn,
    };

    var response = await http.post(Uri.parse(url), body: data);
    // print("login url: $response");
    var responsebody = jsonDecode(response.body);
    // print("login url: $responsebody");

    if (responsebody['status'] == "success") {
      user_id=responsebody['user_id'];
      userName=responsebody['username'];
      _token=tokenn;
      //save data  in shared preference
      CacheHelper.saveData(key: "username", value: responsebody['username']);
      CacheHelper.saveData(key: "mobile", value: responsebody['mobile']);
      CacheHelper.saveData(key: "use_id", value: responsebody['id']);
      CacheHelper.saveData(key: "token", value: responsebody['token']);

      userAuthed = CacheHelper.getData(key: 'use_id');

      return true ;

    }
    else if(responsebody['status'] == "already found"){
      //Navigator.of(ctxt).pop();
      showDialogAll(ctxt, "خطأ", "رقم الهاتف موجود مسبقا, لايمكن التسجيل به. ادخل رقم أخر.");
      return false ;

    }

    notifyListeners();
  }


 login(String  phone,String  pwd,BuildContext ctxt,String  tokenn) async {

    var data = {
      "mobile": phone,
      "password": pwd,
      "token": tokenn,
    };

    var url = path_api + "users/login.php";

    var response = await http.post(Uri.parse(url), body: data);

    var responsebody = jsonDecode(response.body);
    if (responsebody['status'] == "success") {

      user_id=responsebody['id'];
      //userAuthed=responsebody['user_id'];
      userName=responsebody['username'];
      _token=tokenn;

      //  save data  inb  shared preference
      CacheHelper.saveData(key: "username", value: responsebody['username']);
      CacheHelper.saveData(key: "mobile", value: responsebody['mobile']);
      CacheHelper.saveData(key: "use_id", value: responsebody['id']);
      CacheHelper.saveData(key: "token", value: responsebody['token']);
      userAuthed=CacheHelper.getData(key:"use_id" );

      Navigator.of(ctxt).pop();
      Navigator.of(ctxt).pushReplacementNamed("home");
    }else {
      Navigator.of(ctxt).pop();

      showDialogAll(ctxt, "خطأ", "البريد الالكتروني او كلمة المرور خاطئة");
      //return false;
    }
    notifyListeners();
  }



  savePref(String username, String mobile, String id,String newtoken) async {
    SharedPreferences preferences= await SharedPreferences.getInstance();

    preferences.setString("use_id", id);
    preferences.setString("username", username);
    preferences.setString("mobile", mobile);
    preferences.setString("token", newtoken);

    // print("user data in sharedPreference :${preferences.getString("username")} "
    //     "AND PHONE: ${preferences.getString("mobile")}"
    //     " and ID:${preferences.getString("use_id")} "
    //     " and token:${preferences.getString("token")} ");

  }

  getDataFromSharedPref() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
     _token =preferences.getString("token");
    userName =preferences.getString("username");
     user_id =preferences.getString("use_id");
     userMobile =preferences.getString("mobile");

    //print("token in getdata is: $_token");
    //  Map<String,dynamic>  userData={
    //   "username":preferences.getString("username"),
    //   "mobile":preferences.getString("mobile"),
    //   "use_id":preferences.getString("use_id"),
    //   "use_token":preferences.getString("token"),
    // };
    //return   _token;

  }

  Future<void> logout() async {
    _token = null;
    user_id = null;
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    //   _authTimer = null;
    // }
    notifyListeners();

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.remove("username") ;
    // preferences.remove("mobile") ;
    // preferences.remove("use_id") ;
    // preferences.remove("token") ;

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}