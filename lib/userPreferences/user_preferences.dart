import 'dart:convert';

import 'package:da_erro/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberPrefs{

  static Future<void> saveUser(User userInfo) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", jsonData);
  }
  
  static Future<User?> readUser() async{
    User? currentUser;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");
    if(userInfo != null){
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUser = User.fromJson(userDataMap);
    }
    return currentUser;
  }

  static Future<void> removerUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}