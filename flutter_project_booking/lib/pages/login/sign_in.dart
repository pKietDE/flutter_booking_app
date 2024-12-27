import 'package:flutter/material.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_style.dart';
import '../../interfaces/constants/assets_color.dart';
import '../../interfaces/constants/assets_image.dart';
import '../../interfaces/constants/assets_icon.dart';

import 'sign_up.dart';
import '../../widgets/my_button.dart';

final button = MyButton();

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController account = TextEditingController();
  final TextEditingController passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child:
                      Image.asset(AssetImages.signinImage, fit: BoxFit.fill)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Image.asset(AssetImages.brandingImage),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: account,
                          decoration: InputDecoration(
                            labelText: "Tài khoản",
                            labelStyle: AssetStyle.h4NotoSerif,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (account) {
                            if (account == null || account.isEmpty) {
                              return "Vui lòng nhập tài khoản .";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: passWord,
                          decoration: InputDecoration(
                            labelText: "Mật khẩu",
                            labelStyle: AssetStyle.h4NotoSans,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (pass) {
                            if (pass == null || pass.isEmpty) {
                              return "Vui lòng nhập mật khẩu.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AssetColor.blue,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("Đăng nhập thành công!");
                            }
                          },
                          child: Text(
                            "Đăng nhập",
                            style: AssetStyle.buttonNotoSans.copyWith(
                              color: AssetColor.textWhite,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Text(
                                "Đăng nhập bằng ",
                                style: AssetStyle.h4NotoSans,
                              ),
                            ),
                            Image.asset(AssetIcon.icFacebook),
                          ],
                        ),
                        Divider(
                          color: AssetColor.softGrey,
                          thickness: 2,
                          indent: 50,
                          endIndent: 50,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Chưa có tài khoản? ",
                              style: AssetStyle.subtitle1NotoSans,
                            ),
                            TextButton(
                              onPressed: () {
                                button.buttonMove(context, SignUpPage(),
                                    isback: false);
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                "Đăng ký",
                                style: AssetStyle.subtitle2NotoSans.copyWith(
                                  color: AssetColor.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
