import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  
   String userIdKey='USERKEY';
   String userNameKey='USERNAMEKEY';
   String userEmailKey='USEREMAILKEY';
   String userProfileKey='USERPROFILEKEY';
  
    Future<bool> saveUserId(String getUserId)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

   Future<bool> saveUserName(String getUserName)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

   Future<bool> saveUserEmail(String getUserEmail)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  
  Future<String?> getUserName()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserId()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

   Future<String?> getUserEmail()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }
}