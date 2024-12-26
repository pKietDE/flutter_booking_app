import 'package:flutter/material.dart';
import '../app_assets/assets_image.dart';
import '../app_assets/assets_icon.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 300,
                        color: Colors.amber,
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
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
