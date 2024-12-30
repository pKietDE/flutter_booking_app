import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/logger.dart';

final logger = MyLogger("API_ACCOUNT");

Future<bool> isPhoneNumberAccount(String phoneNumber) async {
  // * url của api
  var url = Uri.http('localhost:3000', '/account/$phoneNumber');

  // * Gửi yêu cầu get
  try {
    var res = await http.get(url);

    if (res.statusCode == 200) {
      // * Chuyển đổi res.body ban đầu là một chuỗi String sang json
      var data = jsonDecode(res.body);

      // * Kiểm tra nếu có tồn tại thì trả về true ngược lại thì là false
      return phoneNumber.contains(data[0]['sodienthoai']);
    } else {
      // *Trả về false nếu API trả về lỗi (status khác 200)
      return true;
    }
  } catch (e) {
    logger.logInfo("Lỗi khi đang get dữ liệu : $e ");
    // *Trả về false trong trường hợp gặp lỗi khi gọi API
    return true;
  }
}
