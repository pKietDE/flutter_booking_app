import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final logger = MyLogger("API_ACCOUNT");
final host = dotenv.env["API_HOST"];
final port = dotenv.env["API_PORT"];

Future<bool> isPhoneNumberAccount(String phoneNumber) async {
  // * url của API
  var url = Uri.http('$host:$port', '/account/$phoneNumber');

  try {
    // * Gửi yêu cầu GET
    var res = await http.get(url);

    if (res.statusCode == 200) {
      // * Chuyển đổi `res.body` từ JSON
      var data = jsonDecode(res.body);

      // * Kiểm tra số điện thoại có khớp không
      return phoneNumber == data['sodienthoai'];
    } else if (res.statusCode == 404) {
      // * Không tìm thấy tài khoản
      return false;
    } else {
      // * Trường hợp mã trạng thái không mong muốn
      return false;
    }
  } catch (e) {
    logger.logInfo("Lỗi khi đang get dữ liệu: $e");
    // * Trả về `false` trong trường hợp gặp lỗi
    return false;
  }
}

Future<bool> postDataAccount(Map<String, String> body) async {
  // * Chuyển đổi body thành dạng JSON
  var bodyData = jsonEncode(
      {"soDienThoai": body["soDienThoai"], "matKhau": body["matKhau"]});

  // * URL của API (không cần truyền tham số trong URL)
  var url = Uri.http('$host:$port', '/account'); // *Địa chỉ API

  // * Gửi yêu cầu POST đến API
  var res = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: bodyData); // *Truyền body vào phần thân request

  try {
    if (res.statusCode == 200) {
      return true; // *Thành công
    } else {
      logger.logError("Error: ${res.statusCode}");
      return false; // *Thất bại
    }
  } catch (e) {
    logger.logError("Error in posting data: $e");
    throw Exception("Lỗi trong quá trình Post dữ liệu");
  }
}

Future<bool> getAccount(
    {required String phoneNumber, required String passWord}) async {
  logger.logInfo("sodienthoai:$phoneNumber , matkhau : $passWord");

  // * URL của API
  var url = Uri.http('$host:$port', '/account/$phoneNumber'); // *Địa chỉ API

  try {
    // * Gửi yêu cầu GET đến API
    var res = await http.get(url);

    if (res.statusCode == 200) {
      // * Chuyển đổi chuỗi string thành json
      var data = jsonDecode(res.body);

      if (data.isNotEmpty &&
          data["sodienthoai"] == phoneNumber &&
          data["matkhau"] == passWord) {
        return true; // * Thành công
      } else {
        logger.logError("Thông tin tài khoản không chính xác.");
        return false; // * Thất bại
      }
    } else {
      logger.logError("Lỗi API: ${res.statusCode}");
      return false; // * Thất bại
    }
  } catch (e) {
    logger.logError("Lỗi khi kết nối API: $e");
    return false; // * Thất bại
  }
}
