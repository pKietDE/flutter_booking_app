import 'package:flutter/material.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_style.dart';
import 'package:flutter_project_booking/pages/login/sign_in.dart';
import 'package:flutter_project_booking/services/dialling_code.dart';
import 'package:flutter_project_booking/widgets/my_button.dart';
import 'confirmt_otp.dart';
import '../../services/account_api.dart';
import '../../interfaces/constants/assets_image.dart';
import '../../interfaces/constants/assets_icon.dart';
import '../../interfaces/constants/assets_color.dart';
import '../../utils/logger.dart';
import '../../utils/regex.dart';

final button = MyButton();
final logger = MyLogger("SignUpPage");

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKeyStep1 = GlobalKey();
  final GlobalKey<FormState> _formKeyStep2 = GlobalKey();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController passWord = TextEditingController();
  final TextEditingController entryPassWord = TextEditingController();
  Map<String, String> dataSignUp = {};
  bool isLoading = true;
  String fullPhoneNumber = "";
  String finalpassWord = "";
  List<String> countryCodes = [];
  String selectedCode = '+84';
  // *Biến để kiểm tra số điện thoại đã tồn tại chưa
  bool isExist = false;
  var step = 1;

  // *Gọi API khi khởi tạo màn hình
  @override
  void initState() {
    super.initState();
    loadDiallingCodes();
  }

  // * Hàm lấy dữ liệu api
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

  // * Hàm kiểm tra số điện thoại đã tồn tại chưa
  Future<void> checkPhoneNumberExistence() async {
    setState(() {
      isLoading = true; // *Hiển thị loading khi kiểm tra
    });
    // *delay 2 giây
    await Future.delayed(Duration(seconds: 2));

    isExist = await isPhoneNumberAccount(fullPhoneNumber);
    setState(() {
      isLoading = false; // *Ẩn loading sau khi kiểm tra xong
    });

    if (isExist) {
      // *Số điện thoại đã tồn tại
      logger.logInfo("Số điện thoại đã tồn tại.");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Số điện thoại này đã tồn tại!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildSignupForm(step: step),
                  const SizedBox(height: 40),
                  _buttonNext(),
                  const SizedBox(height: 40),

                  // * Nếu Step = 1 :
                  // * thì vẫn hiện  _textLoginWith()
                  if (step == 1) ...[
                    _textLoginWith(),
                  ]
                ],
              ),
            ),
    );
  }

  Widget _textLoginWith() {
    return Column(
      children: [
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
              "Đã có tài khoản ? ",
              style: AssetStyle.subtitle1NotoSans,
            ),
            TextButton(
              onPressed: () {
                button.buttonMove(context, SignInPage(), isback: false);
              },
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                "Đăng Nhập",
                style: AssetStyle.subtitle2NotoSans.copyWith(
                  color: AssetColor.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: AssetColor.blue,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buttonNext() {
    String textButton = "";
    step == 1 ? textButton = "Tiếp tục" : textButton = "Đăng ký tài khoản";
    return SizedBox(
      width: 320,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AssetColor.blue,
          ),
          onPressed: () async {
            if (step == 1) {
              if (_formKeyStep1.currentState != null &&
                  _formKeyStep1.currentState!.validate()) {
                setState(() {
                  fullPhoneNumber = "$selectedCode${phoneNumber.text}";
                  logger.logInfo("Set FullphoneNumber = $fullPhoneNumber");
                });

                // *Kiểm tra số điện thoại trước khi chuyển sang bước 2
                await checkPhoneNumberExistence();
                if (!isExist) {
                  setState(() {
                    step =
                        2; // Chuyển sang bước 2 nếu số điện thoại không tồn tại
                  });
                }
              }
            } else {
              if (_formKeyStep2.currentState != null &&
                  _formKeyStep2.currentState!.validate()) {
                setState(() {
                  finalpassWord = entryPassWord.text;
                });
                // * Di chuyển đến trang OTP
                button.buttonMove(
                    context,
                    OtpPage(
                      password: finalpassWord,
                      phoneNumber: fullPhoneNumber,
                    ),
                    isback: true);
              }
            }
          },
          child: Text(
            textButton,
            style: AssetStyle.buttonNotoSans.copyWith(
              color: AssetColor.textWhite,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.asset(
            AssetImages.singupImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetIcon.icBrandingB,
                height: 55,
              ),
              Image.asset(
                AssetIcon.icBookingcom,
                height: 35,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignupForm({required int step}) {
    String title = "";
    step == 1 ? title = "Đăng Ký" : title = "Tạo Tài Khoản";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            title,
            style: AssetStyle.h4NotoSans.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          _buildStepIndicator(),
          const SizedBox(height: 50),
          if (step == 1) ...[
            _buildPhoneInput(),
          ] else ...[
            _buildPassWordInput(),
          ]
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Email",
              style:
                  AssetStyle.body2NotoSans.copyWith(color: AssetColor.softGrey),
            ),
            const SizedBox(width: 35),
            Text(
              "Pass",
              style:
                  AssetStyle.body2NotoSans.copyWith(color: AssetColor.softGrey),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepCircle(1),
            Container(
              width: 40,
              height: 5,
              color: AssetColor.softGrey,
            ),
            _buildStepCircle(2),
          ],
        ),
      ],
    );
  }

  Widget _buildStepCircle(int stepNumber) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: step == stepNumber ? AssetColor.blue : AssetColor.softGrey,
        shape: BoxShape.circle,
      ),
      child: step == stepNumber
          ? Image.asset(
              AssetIcon.icTick,
              color: AssetColor.textWhite,
            )
          : null,
    );
  }

  Widget _buildPassWordInput() {
    return Column(children: [
      SizedBox(
        width: 300,
        child: Form(
          key: _formKeyStep2,
          child: Column(
            children: [
              TextFormField(
                controller: passWord,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                // * Validate Mật khẩu
                validator: (passWord) {
                  if (passWord == null || passWord.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  if (!MyRegex.isValidPassword(passWord)) {
                    return 'Mật khẩu phải có : 1 Chữ cái in hoa \n1 ký tự đặc biệt \n1 số bất kỳ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  labelStyle: AssetStyle.h4NotoSans,
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: entryPassWord,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                // * Validate mật khẩu và kiêm tra mật khẩu có trùng ko
                validator: (entryPassWord) {
                  if (entryPassWord == null || entryPassWord.isEmpty) {
                    return 'Vui lòng nhập lại mật khẩu';
                  }
                  if (!entryPassWord.contains(passWord.text)) {
                    return 'Mật khẩu không trùng khớp';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nhập lại mật khẩu",
                  labelStyle: AssetStyle.h4NotoSans,
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildPhoneInput() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
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
              color: AssetColor.softGrey,
            ),
            Expanded(
                flex: 2,
                child: Form(
                  key: _formKeyStep1,
                  child: TextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone,
                    // * Validate số điện thoại
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                )),
          ],
        ));
  }
}
