import 'package:flutter/material.dart';

import 'package:klok/base/base_page.dart';
import 'package:klok/constants/app_color.dart';
import 'package:klok/constants/app_fontsize.dart';
import 'package:klok/model/user.model.dart';
import 'package:klok/viewmodel/index.vm.dart';
import 'package:klok/viewmodel/qr_code.vm.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:stacked/stacked.dart';

class QrCodePage extends StatefulWidget {
  QrCodePage(
      {super.key, required this.qrViewModel, required this.indexViewModel});
  final QRCodeViewModel qrViewModel;
  final IndexViewModel indexViewModel;
  Users? user;
  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  //final List<String> scannedQRCodes = [];
  late MobileScannerController scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates, // Không phát hiện trùng lặp
  );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.indexViewModel.qrCodeViewModel,
        onViewModelReady: (viewModel) async {
          viewModel.indexViewModel = widget.indexViewModel;
          viewModel.scannerController = scannerController;
          viewModel.viewContext = context;
        },
        builder: (context, viewModel, child) {
          viewModel.viewContext = context;
          return BasePage(
            body: Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Stack(children: [
                            MobileScanner(
                              controller: viewModel.scannerController,
                              onDetect: (qrcode) async {
                                // if (!viewModel.isScanQr) {
                                viewModel.isScanQr = true;
                                final List<Barcode> barcodes = qrcode.barcodes;
                                for (final barcode in barcodes) {
                                  final String? rawValue = barcode.rawValue;
                                  if (rawValue != null) {
                                    viewModel.currentQRCode = rawValue;
                                    viewModel.viewContext = context;
                                    print('cssss ${viewModel.currentQRCode} ');
                                    // await viewModel.loadQrCode(rawValue);
                                    await viewModel.getUsers();
                                    print(rawValue);
                                    print('Barcode found! $rawValue');
                                    // viewModel.scannerController!.stop();
                                  }
                                  // }
                                }
                              },
                            ),
                            QRScannerOverlay(
                              overlayColor: Colors.black.withOpacity(0.5),
                              scanAreaSize: Size(
                                  250, 250), // Kích thước cố định cho vùng quét
                            ),
                          ])),
                    ],
                  ),
                  Positioned(
                      top: 50, // Adjust the bottom position as needed
                      left: 0,
                      right: 0,
                      child: Center(
                          child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.redAccent
                              .withOpacity(0.5), // Semi-transparent background
                        ),
                        child: Text(
                          'Hãy đưa mã QR vào giữa khung',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppFontSize.sizeSmall,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ))),
                  Positioned(
                      bottom: 100, // Adjust the bottom position as needed
                      left: 0,
                      right: 0,
                      child: Center(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  shape: BoxShape
                                      .circle // Semi-transparent background
                                  ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    viewModel.isFlashOn = !viewModel.isFlashOn;
                                  });
                                  scannerController.toggleTorch();
                                },
                                icon: viewModel.isFlashOn
                                    ? Icon(
                                        Icons.flash_on_sharp,
                                      )
                                    : Icon(
                                        Icons.flash_off_sharp,
                                      ),
                              ))))
                ],
              ),
            ),
            title: 'Checkin QR Code',
          );
        });
  }
}
