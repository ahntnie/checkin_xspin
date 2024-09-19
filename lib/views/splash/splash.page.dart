import 'package:flutter/material.dart';
import 'package:klok/app/app_sp.dart';
import 'package:klok/app/app_sp_key.dart';
import 'package:klok/constants/app_color.dart';
import 'package:klok/views/auth/sign_in.dart';
import 'package:klok/views/index/index.page.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    if (AppSP.get(AppSPKey.tenTK) != null &&
        AppSP.get(AppSPKey.password) != null &&
        AppSP.get(AppSPKey.idSuKien) != null &&
        AppSP.get(AppSPKey.tenTK) != '' &&
        AppSP.get(AppSPKey.password) != '' &&
        AppSP.get(AppSPKey.idSuKien) != '') {
      await Future.delayed(const Duration(seconds: 2), () {
        // Tải ảnh trong 3 giây
        //precacheImage(const AssetImage('assets/imgStart.png'), context);
      });
      // Chuyển sang màn hình tiếp theo
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IndexPage()),
      );
    } else {
      await Future.delayed(const Duration(seconds: 2), () {
        // Tải ảnh trong 3 giây
        //precacheImage(const AssetImage('assets/imgStart.png'), context);
      });
      // Chuyển sang màn hình tiếp theo
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => const LoginPage()),
      // );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.extraColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0), // Bán kính bo góc
              child: Image.asset(
                'assets/xsipin.png',
                width: MediaQuery.of(context).size.width *
                    0.8, // Chiếm 60% chiều rộng màn hình
              ),
            ),
          ),
          Lottie.asset('assets/qrCode.json', width: 200, height: 200),
        ],
      ),
    );
  }
}
