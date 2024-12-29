import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_icon.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_style.dart';
import 'package:flutter_project_booking/pages/login/sign_up.dart';
import 'package:flutter_project_booking/widgets/my_button.dart';
import '../../interfaces/constants/assets_color.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'dart:async';

final button = MyButton();

class OtpPage extends StatefulWidget {
  final String? phoneNumber;
  final String? password;

  const OtpPage({super.key, required this.phoneNumber, required this.password});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int remainingTime = 120;
  Timer? _timer;
  final formKey = GlobalKey<FormState>();
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  bool isOtpFilled = false;
  String verificationId = "";

  @override
  void initState() {
    """
    initState() : là hàm khi khởi tạo widget nó sẽ chạy cái này đầu tiên .
    _startCountdown() : Hàm để bắt đầu trừ giây
    _sendOtp() : Là hàm được sử dụng để gửi OTP đến số điện thoại
    addListener : Phương thức để lắng nghe các hành động được thực thi bởi một đối tượng nào đó 

    Mục đích : Để khi vừa khởi tạo Widget thì sẽ bắt đầu trừ đi giây đã gửi otp để có thể
    loại bỏ việc vô hiệu hóa của button gửi lại otp , và để kiểm tra khi các controller 
    được thay đổi thì sẽ bắt đầu hàm _checkOtpStatus . 
    """;

    super.initState();
    _startCountdown();
    _sendOtp();
    // Lắng nghe sự thay đổi của các controllers
    for (var controller in controllers) {
      controller.addListener(_checkOtpStatus);
    }
  }

  void onResendCode() {
    setState(() {
      remainingTime = 120;
      for (var controller in controllers) {
        controller.clear(); // * Xóa đi dữ liệu chứa trong các ô
      }
      _startCountdown(); // * Bắt đầu đếm lại
    });

    _sendOtp(); // * Gửi lại Otp
  }

  Future<void> _sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        logger.logInfo("${widget.phoneNumber} Đăng ký thành công");
      },
      verificationFailed: (FirebaseAuthException e) {
        logger.logError("Lỗi: ${e.message}");
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
        });
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  Future<void> verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: controllers.map((controller) => controller.text).join(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      logger.logInfo("Đăng ký thành công");
      // Navigate to next page or show success message
    } catch (e) {
      logger.logError("Lỗi xác thực OTP: ${e.toString()}");
      // Show error message to the user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Mã OTP không chính xác. Vui lòng thử lại."),
        ));
      }
    }
  }

  void _checkOtpStatus() {
    """
    every : giá trị trả về sẽ là true hoặc false dựa vào điều kiện bên trong của nó 

    Khi tất cả các controllers đều thỏa điều kiện thì : filled sẽ trả về true.

    Nếu filled != isOtpFilled có nghĩa : thằng filled đã trả về đúng điều kiện 
    là tất cả các ô đều có số . 

    Thì lúc này phải set lại biến isOtpFilled = filled tức là = true 

    Mục đích : là để button xác nhận không bị vô hiệu hóa nữa
    """;

    bool filled =
        controllers.every((controller) => controller.text.length == 1);
    if (filled != isOtpFilled) {
      setState(() {
        isOtpFilled = filled;
      });
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Xác nhận mã OTP",
          style: AssetStyle.h4NotoSans,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _imageLock(),
                        SizedBox(height: 20),
                        Text(
                          "Đã gửi OTP đến số: ${widget.phoneNumber}",
                          style: AssetStyle.body2NotoSans,
                        ),
                        SizedBox(height: 5),
                        Text.rich(
                          TextSpan(
                            style: AssetStyle.body2NotoSans,
                            children: [
                              TextSpan(text: "Thay đổi: "),
                              TextSpan(
                                text: 'số điện thoại?',
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
                        SizedBox(height: 40),
                        Form(
                          key: formKey,
                          child: _inputOTP(context, controllers),
                        ),
                        SizedBox(height: 20),
                        Text.rich(
                          TextSpan(
                            text: "Thời gian gửi lại code: ",
                            style: AssetStyle.subtitle1NotoSans,
                            children: [TextSpan(text: "${remainingTime}s")],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _layoutButton(remainingTime, formKey, isOtpFilled, onResendCode,
                    verifyOtp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _imageLock() {
  return Image.asset(
    AssetIcon.icLock3x,
    fit: BoxFit.contain,
    width: 150,
  );
}

Widget _inputOTP(
    BuildContext context, List<TextEditingController> controllers) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double inputWidth = (constraints.maxWidth - 30) / 6;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          6,
          (index) => SizedBox(
            width: inputWidth,
            child: TextFormField(
              controller: controllers[index],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Không được bỏ trống";
                }
                return null;
              },
              onChanged: (value) {
                if (value.length == 1 && index < 5) {
                  FocusScope.of(context).nextFocus();
                }
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _layoutButton(remainingTime, formKey, bool isOtpFilled,
    VoidCallback onResendCode, VoidCallback verifyOtp) {
  return SizedBox(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: remainingTime > 0
                  ? null
                  : () {
                      onResendCode();
                    },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(),
                side: BorderSide(
                  color: remainingTime > 0
                      ? AssetColor.softGreen
                      : AssetColor.blue,
                  width: 1,
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                "Gửi lại mã",
                style: AssetStyle.h4NotoSans.copyWith(
                    color: remainingTime > 0
                        ? AssetColor.softGrey
                        : AssetColor.blue),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: TextButton(
              onPressed: isOtpFilled
                  ? () {
                      if (formKey.currentState!.validate()) {
                        verifyOtp();
                      }
                    }
                  : null,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(),
                side: BorderSide(
                  color: isOtpFilled ? AssetColor.blue : AssetColor.softGrey,
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                "Xác nhận",
                style: AssetStyle.h4NotoSans.copyWith(
                  color: isOtpFilled ? AssetColor.blue : AssetColor.softGrey,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
