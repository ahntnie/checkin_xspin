import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:klok/app/app_sp.dart';
import 'package:klok/app/app_sp_key.dart';

import 'package:klok/model/user.model.dart';
import 'package:klok/requests/history_user.requets.dart';
import 'package:klok/requests/qrcode.request.dart';
import 'package:klok/viewmodel/index.vm.dart';
import 'package:klok/viewmodel/login.vm.dart';
import 'package:klok/views/qr_code/widgets/success_qr.wiget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';

class QRCodeViewModel extends BaseViewModel {
  late BuildContext viewContext;
  QRCodeRequest qrCodeRequest = QRCodeRequest();
  List<Users>? listUser;
  Users? currentUser;
  String? currentQRCode;
  bool? scanQrCode;
  // late Users detailUser;
  UserRequest userRequest = UserRequest();
  MobileScannerController? scannerController;
  late IndexViewModel indexViewModel;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool isScanQr = false;
  String? lastScannedQRCode;
//Cần xem lại đoạn này
  @override
  void dispose() {
    scannerController?.dispose();
    super.dispose();
  }

  loadQrCode(String maQR) async {
    currentUser = await qrCodeRequest.checkIn(
        idSuKien: AppSP.get(AppSPKey.idSuKien), maQR: maQR);
  }

  getUsers() async {
    setBusy(true);
    print('Vô get');
    currentUser = await qrCodeRequest.getUser(
        idSuKien: AppSP.get(AppSPKey.idSuKien), maQR: currentQRCode!);
    if (currentUser != null) {
      if (currentUser!.isCheckin == false) {
        loadQrCode(currentQRCode!);
        showSuccessScanQrCode();
        scannerController!.stop();
      } else {
        showQRCodeAlreadyScannedDialog(viewContext,
            'Mã QR ${currentQRCode} đã được quét vào lúc ${currentUser!.thoiDiemCheckin}');
        scannerController!.stop();
      }
    } else {
      showQRCodeFailed(viewContext, 'Mã QR Code không tồn tại');
      scannerController!.stop();
    }
    setBusy(false);
    notifyListeners();
  }

  showSuccessScanQrCode() {
    print('Nhảy');
    scannerController!.stop();
    Navigator.push(
        viewContext,
        MaterialPageRoute(
            builder: (context) => SuccessScreenQR(qrCodeViewModel: this)));
    ;
  }

  void showQRCodeAlreadyScannedDialog(BuildContext context, String desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.topSlide,
      title: 'Mã đã quét',
      desc: desc,
      btnOkOnPress: () {
        scannerController!.start();
        // Navigator.maybePop(context);
      },
    )..show();
  }

  void showQRCodeFailed(BuildContext context, String desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      title: 'QRCode Không tồn tại',
      desc: desc,
      btnOkOnPress: () {
        scannerController!.start();
      },
    )..show();
  }
}
