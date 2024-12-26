import 'package:flutter/material.dart';
import '../interfaces/button.dart';
import '../utils/logger.dart';

class MyButton extends IButton {
  final logger = MyLogger("Class ButtonMove");

  @override
  void buttonMove(context, route, {required isback}) {
    try {
      if (isback == true) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => route), (route) => false);
      }
    } on Exception catch (e) {
      logger.logError("Lỗi khi chuyển trang : *** Lỗi *** : *** $e ***");
    }
  }
}
