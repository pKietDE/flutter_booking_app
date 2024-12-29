import 'package:flutter/material.dart';

abstract class IButton {
  //* Button Di chuyển trang
  void buttonMove(BuildContext context, Widget route, {required bool isback});
}
