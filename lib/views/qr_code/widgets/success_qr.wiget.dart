import 'dart:async';

import 'package:flutter/material.dart';
import 'package:klok/constants/app_color.dart';
import 'package:klok/constants/app_fontsize.dart';
import 'package:klok/viewmodel/qr_code.vm.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class SuccessScreenQR extends StatefulWidget {
  final QRCodeViewModel qrCodeViewModel;

  SuccessScreenQR({super.key, required this.qrCodeViewModel});

  @override
  State<SuccessScreenQR> createState() => _SuccessScreenQRState();
}

class _SuccessScreenQRState extends State<SuccessScreenQR> {
  bool _isLoading = false; // Trạng thái đang tải
  String? errorMessage; // Thông báo lỗi nếu có

  Future<void> _onContinuePressed() async {
    setState(() {
      _isLoading = true; // Hiển thị spinner
      errorMessage = null; // Xóa lỗi nếu có trước đó
    });

    try {
      // Bắt đầu bộ đếm thời gian 30 giây
      final timeout = Future.delayed(Duration(seconds: 30), () {
        if (_isLoading) {
          setState(() {
            _isLoading = false;
            _showSnackBar(
                'Sự cố internet. Vui lòng thử lại.'); // Hiển thị SnackBar
          });
        }
      });

      // Kiểm tra nếu `indexViewModel` và `usersViewModel` không phải null
      if (widget.qrCodeViewModel.indexViewModel.usersViewModel != null) {
        await widget.qrCodeViewModel.indexViewModel.usersViewModel
            .getUsers()
            .timeout(
              Duration(seconds: 30),
              onTimeout: () =>
                  throw TimeoutException('Sự cố internet. Vui lòng thử lại.'),
            );

        if (mounted) {
          Navigator.maybePop(context);
          widget.qrCodeViewModel.viewContext = context;
          widget.qrCodeViewModel.scannerController?.start();
        }
      } else {
        throw Exception('Không thể tải dữ liệu người dùng.');
      }

      await timeout; // Chờ thời gian kết thúc
    } catch (e) {
      _showSnackBar('Có lỗi xảy ra: $e'); // Hiển thị SnackBar khi có lỗi
    } finally {
      setState(() {
        _isLoading = false; // Dừng hiển thị spinner
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.qrCodeViewModel,
        onViewModelReady: (viewModel) async {
          Future.microtask(() async {
            await viewModel.indexViewModel.loginViewModel.loadUser();
            viewModel.viewContext = context;
          });
        },
        builder: (context, viewModel, child) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 100,
                        height: 100,
                        child: Lottie.asset('assets/successIcon.json'),
                      ),
                      const SizedBox(height: 20),
                      viewModel.isBusy
                          ? LoadingAnimationWidget.threeRotatingDots(
                              color: AppColor.primaryColor,
                              size: 50,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (viewModel.currentUser != null) ...[
                                  // _buildFieldRow('Mã QR Code',
                                  //     viewModel.currentUser!.maQR),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Mã QR:',
                                        style: TextStyle(
                                            fontSize: AppFontSize.sizeLarge,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        viewModel.currentUser!.maQR,
                                        style: TextStyle(
                                            fontSize: AppFontSize.sizeLarge,
                                            fontWeight: FontWeight.w900,
                                            color: AppColor.successQRCode),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field2,
                                      viewModel.currentUser!.field2),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field3,
                                      viewModel.currentUser!.field3),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field4,
                                      viewModel.currentUser!.field4),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field5,
                                      viewModel.currentUser!.field5),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field6,
                                      viewModel.currentUser!.field6),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field7,
                                      viewModel.currentUser!.field7),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field8,
                                      viewModel.currentUser!.field8),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field9,
                                      viewModel.currentUser!.field9),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field10,
                                      viewModel.currentUser!.field10),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field11,
                                      viewModel.currentUser!.field11),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field12,
                                      viewModel.currentUser!.field12),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field13,
                                      viewModel.currentUser!.field13),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field14,
                                      viewModel.currentUser!.field14),
                                  _buildFieldRow(
                                      viewModel.indexViewModel.loginViewModel
                                          .userLogin!.field15,
                                      viewModel.currentUser!.field15),
                                ] else ...[
                                  Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: AppFontSize.sizeSmall,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                      const SizedBox(height: 30),
                      _isLoading
                          ? LoadingAnimationWidget.threeRotatingDots(
                              color: AppColor.primaryColor,
                              size: 50,
                            )
                          : ElevatedButton(
                              onPressed: _onContinuePressed,
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors
                                        .redAccent.shade400; // Màu khi nhấn
                                  }
                                  return AppColor.primaryColor; // Màu mặc định
                                }),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all(10),
                              ),
                              child: Text(
                                "Tiếp tục quét",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // Hàm để xây dựng dòng cho các field
  Widget _buildFieldRow(String? loginField, String? userField,
      {bool isImportant = false}) {
    if (loginField == null && userField == null) {
      return SizedBox.shrink(); // Không hiển thị nếu cả hai đều là null
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (loginField != null) ...[
          Text(
            loginField,
            style: TextStyle(
                fontSize: AppFontSize.sizeMedium,
                // fontWeight: isImportant ? FontWeight.bold : FontWeight.normal,
                fontWeight: AppFontWeight.bold),
          ),
        ],
        SizedBox(height: 8),
        if (userField != null && userField.isNotEmpty) ...[
          Text(
            userField,
            style: TextStyle(
              fontSize: AppFontSize.sizeSmall,
              fontWeight: isImportant ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
        Divider(height: 28, thickness: 0.5),
      ],
    );
  }
}
