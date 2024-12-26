import 'package:flutter/material.dart';
import '../../interfaces/constants/assets_color.dart';
import '../../interfaces/constants/assets_image.dart';
import '../../interfaces/constants/assets_style.dart';
import '../../interfaces/constants/assets_icon.dart';
import '../../widgets/my_button.dart';
import '../../utils/logger.dart';
import '../login/sign_in.dart';
import '../../widgets/alert.dart';

// *Kiởi tạo các đối tượng
final alert = AlertSignIn();
final button = MyButton();
final logger = MyLogger("Page Introduce");

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: AssetColor.lightBlue,
          appBarTheme: AppBarTheme(backgroundColor: AssetColor.lightBlue)),
      title: "Introduce page",
      home: IntroducePage(),
    );
  }
}

class IntroducePage extends StatelessWidget {
  const IntroducePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  AssetImages.introduceImage,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 300,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Image.asset(AssetImages.brandingImage),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 300,
                                  child: ListView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AssetColor.softGreen,
                                                width: 3)),
                                        margin: EdgeInsets.only(bottom: 20),
                                        height: 65,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AssetIcon.icHome3D, // Icon nhà
                                              width: 50,
                                              height: 50,
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              'Cập nhật & Trạng thái đặt phòng',
                                              style: AssetStyle.body1.copyWith(
                                                  color: AssetColor.freshBlue,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AssetColor.softGreen,
                                                width: 3)),
                                        margin: EdgeInsets.only(bottom: 20),
                                        height: 65,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AssetIcon
                                                  .icTechnicalSupport, // Icon nhà
                                              width: 50,
                                              height: 50,
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              'Cập nhật trạng thái hỗ trợ',
                                              style: AssetStyle.body1.copyWith(
                                                  color: AssetColor.freshBlue,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AssetColor.softGreen,
                                                width: 3)),
                                        margin: EdgeInsets.only(bottom: 10),
                                        height: 65,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AssetIcon.icVoucher, // Icon nhà
                                              width: 50,
                                              height: 50,
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              'Ưu đãi gần đây & Quảng cáo',
                                              style: AssetStyle.body1.copyWith(
                                                  color: AssetColor.freshBlue,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 20), // Khoảng cách bên trên 20px
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    shape: CircleBorder(),
                    fillColor: Colors.blue,
                    onPressed: () {
                      // await PreferenceHelper.hasSeenIntroduce();

                      // ? Kiểm tra context có còn tồn tại hay không ?
                      // * Nếu có => Di chuyển đến trang đăng nhập
                      // alert.alertSystem(context,
                      //     typeAlert: EnumAlert.singin, isSuccess: false);

                      if (context.mounted) {
                        button.buttonMove(context, SignInPage(), isback: false);
                      }
                    },
                    constraints: BoxConstraints(
                      minWidth: 75,
                      minHeight: 75,
                    ),
                    child: Image.asset(AssetIcon.icRight),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
