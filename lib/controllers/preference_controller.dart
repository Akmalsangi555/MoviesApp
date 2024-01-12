import 'dart:developer';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesController extends GetxController {
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();

  ///
  ///
  ///

  Future<void> setString(String key, String value) async {
    encryptedSharedPreferences.setString(key, value);
  }

  Future<void> setListString(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  ///
  ///
  ///

  Future<String> getString(key) async {
    String val = await encryptedSharedPreferences.getString(key);
    log("this is the value from  prefs controller $key == $val");
    return val;
  }

  Future<List<String>?> getListString(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? val = prefs.getStringList(key);
    log("this is the value from  prefs controller $key == $val");
    return val;
  }
}
