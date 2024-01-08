import 'package:da_erro/model/user.dart';
import 'package:da_erro/userPreferences/user_preferences.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController{
  Rx<User> currentUser = User(0, '', '', '').obs;

  User get user => currentUser.value;

  getUserInfo() async{
    User? localStorage = await RememberPrefs.readUser();
    currentUser.value = localStorage!;
  }
}