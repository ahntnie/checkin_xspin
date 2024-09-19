import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:klok/constants/app_color.dart';
import 'package:klok/constants/app_fontsize.dart';
import 'package:klok/model/user.model.dart';
import 'package:klok/viewmodel/history_users.vm.dart';
import 'package:klok/views/history/widgets/item.widget.dart';
import 'package:stacked/stacked.dart';

class QRCodeHistoryList extends StatefulWidget {
  final UsersViewModel usersViewModel;
  final List<Users> users;
  QRCodeHistoryList(
      {super.key, required this.usersViewModel, required this.users});

  @override
  State<QRCodeHistoryList> createState() => _QRCodeHistoryListState();
}

class _QRCodeHistoryListState extends State<QRCodeHistoryList> {
  int _itemsToShow = 5;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => widget.usersViewModel,
      onViewModelReady: (viewModel) {
        viewModel.viewContext = context;
      },
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                _itemsToShow < widget.users.length
                    ? _itemsToShow
                    : widget.users.length,
                (index) {
                  return ItemTicketQR(
                    onTap: () {
                      viewModel.detailUser = widget.users[index];
                      viewModel.viewContext = context;
                      viewModel.nextDetailTicket();
                    },
                    usersViewModel: viewModel,
                    user: widget.users[index],
                  );
                },
              ),
              if (_itemsToShow < widget.users.length)
                TextButton(
                  onPressed: () {
                    setState(() {
                      // Tăng số lượng mục hiển thị thêm 5
                      _itemsToShow += 5;
                    });
                  },
                  child: Text(
                    'Xem thêm',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: AppFontSize.sizeMedium,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
