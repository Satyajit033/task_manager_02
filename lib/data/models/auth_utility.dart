import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_2/data/models/login_model.dart';

class AuthUtility {
  AuthUtility._();
  static LoginModel userInfo = LoginModel();

  static Future<void> saveUserInfo(LoginModel model) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.setString('user-data', jsonEncode(model.toJson()));
    userInfo = model;
  }

  static Future<void> updateUserInfo(UserData data) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    userInfo.data = data;
    await _sharedPrefs.setString('user-data', jsonEncode(userInfo.toJson()));
  }

  static Future<LoginModel> getUserInfo() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    String value = _sharedPrefs.getString('user-data')!;
    return LoginModel.fromJson(jsonDecode(value));
  }


  static Future<void> clearUserInfo() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
  }

  static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    bool isLogin = _sharedPrefs.containsKey('user-data');
    if (isLogin) {
      userInfo = await getUserInfo();
    }
    return isLogin;
  }
}

/*ShowBase64Img(Base64String){
  UriData? data = Uri.parse(Base64String).data;
  Uint8List MyImg =  data!.contentAsBytes();
  return MyImg;
}*/

