import 'package:flutter/material.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_color.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_icon.dart';
import 'package:flutter_project_booking/interfaces/constants/assets_style.dart';

class PageSearch extends StatefulWidget {
  const PageSearch({super.key});

  @override
  State<PageSearch> createState() => _PageSearchState();
}

class _PageSearchState extends State<PageSearch> {
  // Biến lưu trạng thái tab đã chọn
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          // * Tab header
          tabHeader(),
          // * Khung tìm kiếm

          // * Quảng cáo

          // * Những tin khác
        ],
      ),
    );
  }

  // * Tab header
  Widget tabHeader() {
    return Container(
      color: AssetColor.freshBlue,
      width: double.infinity,
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Tab 1
            tabItem(0, "Lưu trú", AssetIcon.icBed2x),
            // Tab 2
            tabItem(1, "Thuê xe", AssetIcon.icCar2x),
            // Tab 3
            tabItem(2, "Taxi", AssetIcon.icTaxi2x),
            // Tab 4
            tabItem(3, "Địa điểm tham quan", AssetIcon.icFairground2x),
          ],
        ),
      ),
    );
  }

  // Widget cho mỗi tab
  Widget tabItem(int index, String title, String imageAsset) {
    bool isActive = selectedTabIndex == index;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTabIndex = index;
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive ? AssetColor.textWhite : AssetColor.freshBlue,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: isActive
                ? AssetColor.textWhite.withValues(alpha: 220)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              // * Icon
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  isActive ? AssetColor.textWhite : AssetColor.softGrey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  imageAsset,
                ),
              ),

              Padding(padding: EdgeInsets.only(right: 10)),
              // * Title
              Text(
                title,
                style: AssetStyle.body1NotoSans.copyWith(
                  color: isActive ? AssetColor.textWhite : AssetColor.softGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
