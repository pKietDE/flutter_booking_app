// import 'package:shared_preferences/shared_preferences.dart';

// class PreferenceHelper {
//   static const String hasSeenIntroduceKey = 'hasSeenIntroduce';

//   // *Lưu trạng thái người dùng đã xem trang giới thiệu
//   static Future<void> setHasSeenIntroduce() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool(hasSeenIntroduceKey, true);
//   }

//   // *Kiểm tra trạng thái
//   static Future<bool> hasSeenIntroduce() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(hasSeenIntroduceKey) ?? false; // *: Mặc định là false
//   }
// }
