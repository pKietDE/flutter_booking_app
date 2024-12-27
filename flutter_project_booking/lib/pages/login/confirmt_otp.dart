import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_icon.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_style.dart';
import 'package:flutter_project_booking/pages/login/sign_up.dart';
import 'package:flutter_project_booking/widgets/my_button.dart';

final button = MyButton();

class OtpPage extends StatefulWidget {
  final String? phoneNumber;
  final String? password;

  const OtpPage({super.key, required this.phoneNumber, required this.password});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirmt OTP",
          style: AssetStyle.h4NotoSans.copyWith(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              // *Image
              _imageLock(),
              SizedBox(
                height: 20,
              ),
              // *Text để thông báo gửi đến số điện thoại nào
              Text(
                "Đã gửi otp đến số : ${widget.phoneNumber}",
                style: AssetStyle.body2NotoSans,
              ),
              SizedBox(
                height: 5,
              ),
              Text.rich(
                textAlign: TextAlign.start,
                TextSpan(
                  style: AssetStyle
                      .body2NotoSans, // Style chung cho toàn bộ văn bản
                  children: [
                    TextSpan(
                      text: "Thay đổi : ",
                    ),
                    TextSpan(
                      text: 'số điện thoại ?',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          button.buttonMove(context, SignUpPage(),
                              isback: false);
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              // *Input OTP
              _inputOTP(context),
              Expanded(child: _layoutButton()),

              // *Row layout Button
            ]),
          ),
        ),
      ),
    );
  }
}

Widget _imageLock() {
  return Image.asset(
    AssetIcon.icLock3x,
    fit: BoxFit.fill,
    width: 150,
  );
}

Widget _inputOTP(BuildContext context) {
  return Row(
    children: [
      Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: 90,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), counterText: ""),
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: 90,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), counterText: ""),
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: 90,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), counterText: ""),
            ),
          )),
      Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: 90,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), counterText: ""),
            ),
          )),
    ],
  );
}

Widget _layoutButton() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Row(
        children: [
          // *Button Render
          // *Button Confirmt
        ],
      )
    ],
  );
}
