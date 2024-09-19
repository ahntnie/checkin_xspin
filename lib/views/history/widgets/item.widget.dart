import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:klok/constants/app_color.dart';
import 'package:klok/constants/app_fontsize.dart';
import 'package:klok/model/user.model.dart';
import 'package:klok/viewmodel/history_users.vm.dart';
import 'package:stacked/stacked.dart';

class ItemTicketQR extends StatefulWidget {
  final String? qrCodeUrl;

  final VoidCallback onTap;
  final Users user;
  UsersViewModel usersViewModel;
  ItemTicketQR(
      {super.key,
      this.qrCodeUrl,
      required this.onTap,
      required this.user,
      required this.usersViewModel});

  @override
  State<ItemTicketQR> createState() => _ItemTicketQRState();
}

class _ItemTicketQRState extends State<ItemTicketQR> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.usersViewModel,
        onViewModelReady: (viewModel) {
          viewModel.viewContext = context;
        },
        builder: (context, viewModel, child) {
          return InkWell(
            onTap: widget.onTap,
            child: Card(
              color: AppColor.cardColor,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(
                title: Text(
                  widget.user.maQR,
                  style: TextStyle(fontWeight: AppFontWeight.bold),
                  overflow: TextOverflow
                      .ellipsis, // Hiển thị dấu ba chấm nếu chữ quá dài
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    widget.user.thoiDiemCheckin != ''
                        ? Text(
                            widget.user.thoiDiemCheckin!,
                            overflow: TextOverflow
                                .ellipsis, // Áp dụng tương tự cho phần mô tả
                          )
                        : Text(
                            'Chưa checkin',
                            style: TextStyle(color: AppColor.selectColor),
                            overflow: TextOverflow
                                .ellipsis, // Áp dụng tương tự cho phần mô tả
                          ),
                    Text(
                      widget.user.field2!,
                      overflow: TextOverflow
                          .ellipsis, // Áp dụng tương tự cho phần mô tả
                    ),
                  ],
                ),
                trailing: Text(
                  widget.user.isCheckin ? "QR đã quét" : "QR chưa quét",
                  style: TextStyle(
                      fontSize: AppFontSize.sizeSuperSmall,
                      color: widget.user.isCheckin == true
                          ? AppColor.successQRCode
                          : AppColor.selectColor),
                  overflow: TextOverflow
                      .ellipsis, // Áp dụng tương tự cho phần trạng thái
                ),
              ),
            ),
          );
        });
  }
}
