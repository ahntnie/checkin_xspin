import 'package:flutter/material.dart';
import 'package:klok/base/base_page.dart';
import 'package:klok/constants/app_color.dart';
import 'package:klok/viewmodel/index.vm.dart';
import 'package:klok/viewmodel/history_users.vm.dart';
import 'package:klok/views/history/widgets/autoscroll.widget.dart';
import 'package:klok/views/history/widgets/list.widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class HistoryPage extends StatefulWidget {
  final UsersViewModel usersViewModel;
  final IndexViewModel indexViewModel;
  const HistoryPage(
      {super.key, required this.usersViewModel, required this.indexViewModel});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      widget.usersViewModel.updateSearchQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await widget.usersViewModel.getUsers(); // Gọi hàm để tải lại dữ liệu
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.usersViewModel,
        onViewModelReady: (viewModel) async {
          viewModel.viewContext = context;
          await viewModel.getUsers();
        },
        builder: (context, viewModel, child) {
          viewModel.viewContext = context;

          return DefaultTabController(
            length: 3, // Số lượng Tab
            child: BasePage(
              title: 'Lịch sử quét QR Code',
              body: Column(
                children: [
                  TabBar(
                    indicatorColor: AppColor.darkColor,
                    labelColor: AppColor.primaryColor,
                    tabs: [
                      Tab(
                        child: Text(
                          'Tất cả',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Tab(
                        child: AutoScrollingText(
                          text: 'Đã Checkin',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Tab(
                        child: AutoScrollingText(
                          text: 'Chưa Checkin',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm theo tên hoặc mã QR',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                AppColor.primaryColor, // Màu viền của TextField
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor
                                .primaryColor, // Màu viền khi TextField được chọn
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                  viewModel.isBusy
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.5),
                          child: Center(
                            child: LoadingAnimationWidget.threeRotatingDots(
                              color: AppColor.primaryColor,
                              size: 50,
                            ),
                          ),
                        )
                      : Expanded(
                          child: TabBarView(
                            children: [
                              RefreshIndicator(
                                onRefresh: _refreshData,
                                child: viewModel.filteredUsers.isEmpty
                                    ? Center(
                                        child: Lottie.asset(
                                            'assets/emptyJson.json'))
                                    : ListView(
                                        children: [
                                          QRCodeHistoryList(
                                            usersViewModel: viewModel,
                                            users: viewModel.filteredUsers,
                                          ),
                                        ],
                                      ),
                              ),
                              RefreshIndicator(
                                onRefresh: _refreshData,
                                child: viewModel.filteredCheckInUser.isEmpty
                                    ? Center(
                                        child: Lottie.asset(
                                            'assets/emptyJson.json'))
                                    : ListView(
                                        children: [
                                          QRCodeHistoryList(
                                            usersViewModel: viewModel,
                                            users:
                                                viewModel.filteredCheckInUser,
                                          ),
                                        ],
                                      ),
                              ),
                              RefreshIndicator(
                                onRefresh: _refreshData,
                                child: viewModel.filteredNotCheckIntUser.isEmpty
                                    ? Center(
                                        child: Lottie.asset(
                                            'assets/emptyJson.json'))
                                    : ListView(
                                        children: [
                                          QRCodeHistoryList(
                                            usersViewModel: viewModel,
                                            users: viewModel
                                                .filteredNotCheckIntUser,
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          );
        });
  }
}
