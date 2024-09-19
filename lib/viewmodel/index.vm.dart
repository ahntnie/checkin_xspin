import 'package:flutter/material.dart';
import 'package:klok/viewmodel/login.vm.dart';
import 'package:klok/viewmodel/qr_code.vm.dart';
import 'package:klok/viewmodel/history_users.vm.dart';
import 'package:klok/views/auth/profile/profile.page.dart';
import 'package:klok/views/history/history.page.dart';
import 'package:klok/views/home/home.page.dart';
import 'package:klok/views/more/more.page.dart';
import 'package:klok/views/qr_code/qr_code.page.dart';
import 'package:stacked/stacked.dart';

class IndexViewModel extends BaseViewModel {
  late BuildContext viewContext;
  int currentIndex = 0;
  late QRCodeViewModel qrCodeViewModel;
  late UsersViewModel usersViewModel;
  late LoginViewModel loginViewModel;

  IndexViewModel() {
    qrCodeViewModel = QRCodeViewModel();
    usersViewModel = UsersViewModel();
    loginViewModel = LoginViewModel();
  }

  Future<void> setIndex(int index) async {
    if (index == 1) {
      // Nếu chuyển sang trang quét QR Code
      qrCodeViewModel.scannerController!.start(); // Khởi tạo và bật camera
    } else {
      // Nếu rời khỏi trang quét QR Code
      qrCodeViewModel.scannerController!.stop(); // Tắt camera
    }

    currentIndex = index;
    notifyListeners();
  }

  List<Widget> getPages() {
    return [
      // HomePage(),
      HistoryPage(
        usersViewModel: usersViewModel,
        indexViewModel: this,
      ),
      QrCodePage(
        qrViewModel: qrCodeViewModel,
        indexViewModel: this,
      ),
      ProfilePage(
        loginViewModel: loginViewModel,
        indexViewModel: this,
      ),
      // MorePage()
    ];
  }
}
