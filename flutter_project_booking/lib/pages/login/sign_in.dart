import 'package:flutter/material.dart';
import 'package:flutter_project_booking/enums/enum_alert.dart';
import 'package:flutter_project_booking/pages/home/customer/page_home.dart';
import 'package:flutter_project_booking/utils/logger.dart';
import '../../interfaces/constants/assets_style.dart';
import '../../interfaces/constants/assets_color.dart';
import '../../interfaces/constants/assets_image.dart';
import '../../interfaces/constants/assets_icon.dart';
import '../../utils/regex.dart';
import '../../services/dialling_code.dart';
import '../../services/account_api.dart';
import 'sign_up.dart';
import '../../widgets/my_button.dart';
import '../../widgets/alert.dart';

final button = MyButton();
final logger = MyLogger("SignIn Page");
final alert = MyAlert();

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController passWord = TextEditingController();
  bool obscureText = true;
  String finalPassword = "";
  String fullPhoneNumber = "";
  List<String> countryCodes = [];
  String selectedCode = '+84';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDiallingCodes();
  }

  void changeObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  // Hàm xác nhận đăng nhập
  Future<void> confimrtSignIn(phoneNumber, passWord) async {
    bool isTrue =
        await getAccount(phoneNumber: phoneNumber, passWord: passWord);

    try {
      if (!isTrue) {
        // * Thông báo cho user Biết
        if (mounted) {
          alert.alertSystem(context,
              typeAlert: EnumAlert.singin, isSuccess: false);
        }
      } else {
        if (mounted) {
          button.buttonMove(context, HomePage(), isback: false);
        } else {
          logger.logError("Không tìm thấy widget để chuyển trang");
        }
      }
    } catch (e) {
      logger.logError("Lỗi : $e");
    }
  }

  // Hàm lấy danh sách mã quốc gia
  Future<void> loadDiallingCodes() async {
    try {
      List<String> codes = await fetchDiallingCodes();
      setState(() {
        countryCodes = codes;
        if (!countryCodes.contains(selectedCode)) {
          selectedCode = countryCodes.isNotEmpty ? countryCodes.first : '+84';
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      logger.logError("Lỗi : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: AssetColor.textWhite,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Image.asset(AssetImages.signinImage,
                              fit: BoxFit.fill)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: [
                        Image.asset(AssetImages.brandingImage),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildPhoneInput(),
                                SizedBox(height: 30),
                                _buildPassInput(
                                    passWord, obscureText, changeObscureText),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AssetColor.blue,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        fullPhoneNumber =
                                            "$selectedCode${phoneNumber.text}";
                                        finalPassword = passWord.text;
                                      });

                                      // * Gọi hàm confimrt để check lại thông tin đăng nhập
                                      confimrtSignIn(
                                          fullPhoneNumber, finalPassword);

                                      logger.logInfo(
                                          "Đăng nhập thành công! số điện thoại : $fullPhoneNumber, Pass : $finalPassword");
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
                                        style: AssetStyle.subtitle2NotoSans
                                            .copyWith(
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  // Widget cho phần nhập số điện thoại
  Widget _buildPhoneInput() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[700]!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DropdownButton<String>(
              value: selectedCode,
              isExpanded: true,
              underline: Container(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              items: countryCodes.map((String code) {
                return DropdownMenuItem(
                  value: code,
                  child: Text(code),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCode = newValue!;
                });
              },
            ),
          ),
          Container(
            height: 55,
            width: 1,
            color: Colors.grey[700]!,
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: phoneNumber,
              keyboardType: TextInputType.phone,
              validator: (phone) {
                if (phone == null || phone.isEmpty) {
                  return 'Vui lòng nhập số điện thoại';
                }
                if (!MyRegex.isValidPhoneNumber(phone)) {
                  return 'Số điện thoại chỉ có 9 số \nKhông có số "0" ở đầu.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Số điện thoại",
                labelStyle: AssetStyle.h4NotoSans,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget cho phần nhập mật khẩu
  Widget _buildPassInput(TextEditingController passWord, bool obscureText,
      VoidCallback changeObscureText) {
    return TextFormField(
      obscureText: obscureText,
      controller: passWord,
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        labelStyle: AssetStyle.h4NotoSans,
        suffixIcon: IconButton(
            onPressed: changeObscureText,
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility)),
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
    );
  }
}
