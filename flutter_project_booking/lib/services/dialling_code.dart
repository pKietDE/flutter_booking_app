import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<String>> fetchDiallingCodes() async {
  // *Load Api Key từ file .env
  await dotenv.load(fileName: '.env');

  // *URL của API
  var url = Uri.https('api.apilayer.com', 'number_verification/countries');

  // *Thêm API Key vào header
  var headers = {
    'Content-Type': 'application/json', // todo: Định dạng nội dung
    'apikey': '${dotenv.env["API_KEY_DIALLINGCODES"]}',
  };

  // *Gửi yêu cầu GET với headers
  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    // *Lấy danh sách dialling_code từ JSON và ép kiểu
    List<String> diallingCodes = [];

    jsonResponse.forEach((key, value) {
      // *Kiểm tra nếu 'dialling_code' tồn tại và ép kiểu về String
      if (value['dialling_code'] != null) {
        diallingCodes.add(value['dialling_code'].toString());
      }
    });

    return diallingCodes;
  } else {
    throw Exception(
        "Lỗi trong quá trình fetch dialling code! Status Code : ${response.statusCode}");
  }
}
