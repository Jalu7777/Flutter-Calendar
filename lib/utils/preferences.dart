import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as s1;

class Preferences{
  static late SharedPreferences pref;
  
static Future<bool> setPref(String key,String value)async{
  s1.log(value.toString());
  pref=await SharedPreferences.getInstance();
  return await pref.setString(key, value);
}
static Future<String> getPref(String key)async{
  pref=await SharedPreferences.getInstance();
  return pref.getString(key)??"";
}
}