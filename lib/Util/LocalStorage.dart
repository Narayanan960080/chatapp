
import 'package:expenses/View/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class LocalStorage{

  static setData({required String key,required String value}) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);

  }

  static Future<String> getLocalData({required String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString(key));
    return Future.value(pref.getString(key) ?? "");
  }

  static logOut(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView()));

  }

}