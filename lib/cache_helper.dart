import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    //هيك بكون عرفت sharedpreferences
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //كيف حبعت قيم
  static Future<bool> setBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  //كيف حجيب
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences?.get(key);
  }

//عن طريقها بحفظ اي حاجة مهما كان النوع
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    } else if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    } else {
      throw Exception("Unsupported value type");
    }
  }

//عشان الحذف
  static Future<bool> clearData({
    required String key,
  }) async {
    return sharedPreferences!.remove(key);
  }
}
