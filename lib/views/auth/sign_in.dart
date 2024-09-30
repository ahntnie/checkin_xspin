import 'package:flutter/material.dart';
import 'package:klok/constants/app_color.dart';
import 'package:klok/constants/app_fontsize.dart';
import 'package:klok/viewmodel/login.vm.dart';
import 'package:klok/views/auth/widget/button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final Uri _url = Uri.parse('https://xspin.vn/dieu-khoan-su-dung');
  Future<void> launchURL() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.viewContext = context;
        },
        builder: (context, viewModel, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.primaryColor,
              body: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColor.extraColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(5, 10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.075,
                        ),
                        Image.asset(
                          'assets/xsipin.png',
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.075,
                        ),
                        // Login Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Đăng Nhập Hệ Thống',
                                  style: TextStyle(
                                    fontSize: AppFontSize.sizeLarge,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.selectColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: launchURL,
                                  child: Text(
                                    'Điều khoản sử dụng',
                                    style: TextStyle(
                                      fontSize: AppFontSize.sizeSuperSmall,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.asset(
                                    'assets/logo_qr.jpg',
                                    width: MediaQuery.of(context).size.width *
                                        0.095,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        // Email Field
                        TextField(
                          controller: viewModel.username,
                          decoration: InputDecoration(
                            hintText: 'Mã sự kiện',
                            filled: true,
                            fillColor: AppColor.extraColor,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(
                                  10.0), // Adjust padding if needed
                              child: SizedBox(
                                width:
                                    20, // Set the width to make the image smaller
                                height:
                                    20, // Set the height to make the image smaller
                                child: Image.asset(
                                  'assets/barcode.png', // Replace with your image path
                                  fit: BoxFit.contain, // Adjust fit as needed
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Password Field
                        TextField(
                          controller: viewModel.password,
                          obscureText: viewModel.obscureText,
                          decoration: InputDecoration(
                            hintText: 'Mật khẩu',
                            filled: true,
                            fillColor: AppColor.extraColor,
                            suffixIcon: Icon(
                              Icons.lock,
                              color: AppColor.primaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),

                        // Remember password and forget password

                        SizedBox(height: 80),
                        // Login and Register buttons
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ButtonCustom(
                              onPressed: () {
                                viewModel.isBusy
                                    ? Center(
                                        child: LoadingAnimationWidget
                                            .threeRotatingDots(
                                          color: AppColor.primaryColor,
                                          size: 50,
                                        ),
                                      )
                                    : viewModel.showSignInSuccessDialog(
                                        context,
                                        viewModel.username.text,
                                        viewModel.password.text);
                              },
                              nameButton: 'Đăng nhập',
                              color: AppColor.primaryColor,
                              colorName: AppColor.extraColor),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: OutlinedButton(
                            onPressed: () {
                              // Handle register button tap
                            },
                            child: Text(
                              'Đăng ký',
                              style: TextStyle(
                                  color: AppColor.selectColor,
                                  fontSize: AppFontSize.sizeSmall),
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              side: BorderSide(
                                color: AppColor.selectColor, // Màu viền đỏ
                                width: 1.0, // Độ dày của viền
                              ),
                            ),
                          ),
                        ),

                        // Login with Touch ID
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
