import 'package:flutter/material.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_color.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_icon.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_style.dart';
import 'package:flutter_project_booking/pages/home/customer/page_booking.dart';
import 'package:flutter_project_booking/pages/home/customer/page_like.dart';
import 'package:flutter_project_booking/pages/home/customer/page_me.dart';
import 'package:flutter_project_booking/pages/home/customer/page_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    const PageSearch(),
    const PageLike(),
    const PageBooking(),
    const PageMe(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColor.textWhite,
      appBar: AppBar(
        toolbarHeight: 80,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 30, 0),
            child: InkWell(
              onTap: () {},
              child: Image.asset(AssetIcon.icbell2x),
            ),
          )
        ],
        title: Text("Booking.com",
            style: AssetStyle.h3NotoSerif.copyWith(
                fontWeight: FontWeight.bold, color: AssetColor.textWhite)),
        centerTitle: true,
        backgroundColor: AssetColor.freshBlue,
      ),
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: AssetColor.softGreen, // Màu của đường viền
            width: 1.0, // Độ dày của đường viền
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    pageIndex == 0
                        ? AssetColor.freshBlue
                        : AssetColor.softGrey, // Màu sắc tùy chỉnh
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    AssetIcon.icSearch,
                  ),
                )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    pageIndex == 1
                        ? AssetColor.freshBlue
                        : AssetColor.softGrey, // Màu sắc tùy chỉnh
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(AssetIcon.icHeartOutline),
                )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    pageIndex == 2
                        ? AssetColor.freshBlue
                        : AssetColor.softGrey, // Màu sắc tùy chỉnh
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(AssetIcon.icCase),
                )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    pageIndex == 3
                        ? AssetColor.freshBlue
                        : AssetColor.softGrey, // Màu sắc tùy chỉnh
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(AssetIcon.icUserRound),
                )),
          ],
        ),
      ),
    );
  }
}
