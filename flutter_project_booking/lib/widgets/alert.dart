// ignore_for_file: unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_project_booking/enums/enum_alert.dart';
import 'my_button.dart';
import '../interfaces/constants/assets_style.dart';

final button = MyButton();

abstract class DialogBuilder {
  void alertSystem(BuildContext context,
      {required bool isSuccess, required Enum typeAlert, int timeShow = 2});
}

class AlertSignIn implements DialogBuilder {
  @override
  void alertSystem(BuildContext context,
      {required Enum typeAlert, bool isSuccess = true, int timeShow = 2}) {
    // *Tạo một biến động để thay đổi
    final String? alert;

    // *Thay đổi giá trị thông báo tùy theo :
    // *isSuccess : True, False
    // *typeAlert : singin, singup , ....
    if (isSuccess && typeAlert == EnumAlert.singin) {
      alert = "Đăng nhập thành công";
    } else if (!isSuccess && typeAlert == EnumAlert.singin) {
      alert = "Đăng nhập thất bại";
    } else {
      alert = "Eror";
    }
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: timeShow), () {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop(); // Tự động đóng dialog
          }
        });
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0), // Bo góc
            side: BorderSide(
              color: Colors.black, // Màu viền
              width: 2.0, // Độ dày viền
            ),
          ),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min, // Chỉ chiếm đủ nội dung
            children: [
              Text(
                '${alert}',
                style: AssetStyle.h4,
              ),
              const SizedBox(
                height: 60,
                width: 150,
                child: Divider(
                  thickness: 2.0, // Độ dày của đường gạch ngang
                  color: Colors.black, // Màu của đường gạch ngang
                ),
              ), // Khoảng cách giữa text và đường ngang
            ],
          ),
        );
      },
    );
  }

  void alertNoData(BuildContext context) {
    /*
    todo: Nếu tài khoản không tồn tại
    todo: thì hiện lên dialog nút để chuyển qua trang đăng ký 
    */
  }
}
