import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:klok/app/app_sp.dart';
import 'package:klok/app/app_sp_key.dart';
import 'package:klok/app/app_string.dart';
import 'package:klok/constants/api.dart';
import 'package:klok/constants/app_color.dart';
import 'package:klok/model/login.model.dart';
import 'package:klok/requests/login.request.dart';

import 'package:klok/services/api_services.dart';
import 'package:klok/viewmodel/index.vm.dart';
import 'package:klok/views/auth/sign_in.dart';
import 'package:klok/views/index/index.page.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  late BuildContext viewContext;
  bool _obscureText = true;
  LoginRequest loginRequest = LoginRequest();
  bool get obscureText => _obscureText;
  final apiService = ApiService();
  late IndexViewModel indexViewModel;
  Login? data;
  late Login responseLogin;
  Login? userLogin;

  void showhidePassword() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  Future<void> loadUser() async {
    setBusy(true);
    // Gọi getUsers và nhận về đối tượng Login
    userLogin = await loginRequest.getUsers(
        tenSK: AppSP.get(AppSPKey.tenTK), mkSK: AppSP.get(AppSPKey.password));

    if (userLogin != null) {
      print("Đăng nhập thành công: ${AppSPKey.tenTK}");
    } else {
      print("Đăng nhập thất bại");
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> showSignInSuccessDialog(
      BuildContext context, String tenSK, String mkSK) async {
    setBusy(true);
    try {
      data = await loginRequest.login(tenSK: tenSK, mkSK: mkSK);

      if (data != null) {
        AppSP.set(AppSPKey.tenTK, tenSK);
        AppSP.set(AppSPKey.password, mkSK);
        AppSP.set(AppSPKey.idSuKien, data!.idSuKien);
        print('Tên đăng nhậssssp: ${AppSP.get(AppSPKey.idSuKien)}');
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: 'Đăng nhập thành công',
          desc: 'Bạn đã đăng nhập thành công vào ứng dụng!',
          btnOkOnPress: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const IndexPage()),
            );
          },
          btnOkText: 'Vào ứng dụng',
        ).show();
      } else {
        // Show error message when login fails
        showSignInFailedDialog(
            context, 'Tài khoản không tồn tại hoặc mật khẩu không chính xác');
      }
    } catch (e) {
      print('Login failed: $e');
      print('${Api.hostApi}${Api.login}');
      showSignInFailedDialog(context,
          'Có lỗi xảy ra trong quá trình đăng nhập, vui lòng thử lại sau');
    }
    setBusy(false);
    notifyListeners();
  }

  void showLogOut(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: 'Thông báo!',
      desc: 'Bạn có muốn đăng xuất ứng dụng?',
      btnCancelOnPress: () {},
      btnCancelText: 'Hủy',
      btnOkOnPress: () {
        AppSP.set(AppSPKey.tenTK, '');
        AppSP.set(AppSPKey.password, '');
        AppSP.set(AppSPKey.idSuKien, '');
        print('ID: ${AppSP.get(AppSPKey.tenTK)}');
        print('Passs: ${AppSP.get(AppSPKey.password)}');
        print('Passs: ${AppSP.get(AppSPKey.idSuKien)}');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignInView()),
        );
      },
      btnOkText: 'Có',
    ).show();
  }

  void showSignInFailedDialog(BuildContext context, String desc) {
    AwesomeDialog(
      context: viewContext,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: 'Đăng nhập thất bại',
      desc: desc,
      btnOkColor: AppColor.selectColor,
      btnOkOnPress: () {},
      btnOkText: 'Thử lại',
    ).show();
  }
}
