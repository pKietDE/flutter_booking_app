import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../interfaces/constants/assets_color.dart';
import '../../interfaces/constants/assets_image.dart';
import '../../interfaces/constants/assets_style.dart';
import '../../interfaces/constants/assets_icon.dart';
import '../../widgets/my_button.dart';
import '../../utils/logger.dart';
import '../login/sign_in.dart';
import '../../widgets/alert.dart';
import '../../firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../utils/preference_helper.dart';

// *Khởi tạo các đối tượng
final alert = MyAlert();
final button = MyButton();
final logger = MyLogger("Page Introduce");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false, // Giữ nguyên dòng này
    home: MyHomePage(), // Thêm const ở đây
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      // *Kiểm tra xem người dùng đã xem giới thiệu chưa
      future: PreferenceHelper.hasSeenIntroduce(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Nếu đang tải, có thể hiển thị một loading indicator
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          // Hiển thị thông báo lỗi nếu có
          return Center(child: Text('Lỗi khi tải dữ liệu'));
        }

        // Kiểm tra nếu người dùng đã xem giới thiệu
        if (snapshot.hasData && snapshot.data == true) {
          // Nếu đã xem giới thiệu, chuyển đến trang đăng nhập
          return const SignInPage();
        } else {
          // Nếu chưa xem, hiển thị trang giới thiệu
          return const IntroducePage();
        }
      },
    );
  }
}

class IntroducePage extends StatefulWidget {
  const IntroducePage({super.key});

  @override
  State<IntroducePage> createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> {
  @override
  void initState() {
    super.initState();
  }

  void _onPressed() async {
    // *Đánh dấu là đã xem trang giới thiệu
    await PreferenceHelper.setHasSeenIntroduce();

    // *Sau khi nhấn nút, chuyển đến trang đăng nhập
    button.buttonMove(context, const SignInPage(), isback: false);
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Image.asset(AssetImages.brandingImage),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 300,
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  _buildFeatureTile(
                                    icon: AssetIcon.icHome3D,
                                    text: 'Cập nhật & Trạng thái đặt phòng',
                                  ),
                                  _buildFeatureTile(
                                    icon: AssetIcon.icTechnicalSupport,
                                    text: 'Cập nhật trạng thái hỗ trợ',
                                  ),
                                  _buildFeatureTile(
                                    icon: AssetIcon.icVoucher,
                                    text: 'Ưu đãi gần đây & Quảng cáo',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    shape: const CircleBorder(),
                    fillColor: Colors.blue,
                    onPressed: _onPressed,
                    constraints: const BoxConstraints(
                      minWidth: 75,
                      minHeight: 75,
                    ),
                    child: Image.asset(AssetIcon.icRight),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile({required String icon, required String text}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AssetColor.softGreen, width: 3),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      height: 65,
      child: Row(
        children: [
          Image.asset(icon, width: 50, height: 50),
          const SizedBox(width: 15),
          Text(
            text,
            style: AssetStyle.body1NotoSans.copyWith(
              color: AssetColor.freshBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
