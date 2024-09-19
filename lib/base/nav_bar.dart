import 'package:flutter/material.dart';
import 'package:klok/constants/app_color.dart';

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });
  final int currentIndex;
  final Future<void> Function(int) onTabSelected;

  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColor.primaryColor,
      currentIndex: widget.currentIndex,
      fixedColor: AppColor.extraColor,
      unselectedItemColor: Colors.grey[600],
      onTap: (index) async {
        await widget.onTabSelected(index);
      },
      items: [
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.home, size: 24),
        //   label: 'Trang chủ',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history, size: 24),
          label: 'Lịch sử',
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: AppColor.selectColor, // Màu nền xung quanh icon
              shape: BoxShape.circle, // Hình dạng vòng tròn
              // borderRadius: BorderRadius.circular(10) // Hình dạng vòng tròn
            ),
            padding: EdgeInsets.all(
                8.0), // Khoảng cách giữa icon và viền của vòng tròn
            child: Center(
              child: Icon(
                Icons.qr_code,
                color: Colors.white, // Màu của icon
                size: 30.0, // Kích thước icon
              ),
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 24),
          label: 'Thông tin',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.menu),
        //   label: 'Khác',
        // )
      ],
    );

    // return CurvedNavigationBar(
    //   index: widget.currentIndex,
    //   onTap: (index) async {
    //     await widget.onTabSelected(index);
    //   },
    //   animationDuration: Duration(milliseconds: 300),
    //   backgroundColor: AppColor.extraColor,
    //   color: AppColor.primaryColor,
    //   items: [
    //     Icon(Icons.home),
    //     Icon(Icons.history),
    //     Icon(Icons.qr_code),
    //     Icon(Icons.person),
    //     Icon(Icons.menu),
    //   ],
    // );
  }
}
