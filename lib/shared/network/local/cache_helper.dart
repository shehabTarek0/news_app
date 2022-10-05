import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<dynamic> setData({
    required String key,
    required var value,
  }) async {
    if (value.runtimeType == bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    if (value.runtimeType == double) {
      return await sharedPreferences!.setDouble(key, value);
    }
    if (value.runtimeType == int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (value.runtimeType == List<String>) {
      return await sharedPreferences!.setStringList(key, value);
    } else {
      return await sharedPreferences!.setString(key, value);
    }
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }
}
