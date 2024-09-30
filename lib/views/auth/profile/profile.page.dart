import 'package:flutter/material.dart';
import 'package:klok/app/app_sp.dart';
import 'package:klok/app/app_sp_key.dart';
import 'package:klok/base/base_page.dart';
import 'package:klok/constants/app_color.dart';
import 'package:klok/constants/app_fontsize.dart';
import 'package:klok/viewmodel/index.vm.dart';
import 'package:klok/viewmodel/login.vm.dart';
import 'package:klok/views/auth/widget/button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatefulWidget {
  final IndexViewModel indexViewModel;
  final LoginViewModel loginViewModel;

  const ProfilePage(
      {super.key, required this.indexViewModel, required this.loginViewModel});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => widget.loginViewModel,
      onViewModelReady: (viewModel) async {
        await viewModel.loadUser();
        await widget.indexViewModel.usersViewModel.getUsers();

        viewModel.viewContext = context;
      },
      builder: (context, viewModel, child) {
        // if (viewModel.isBusy || viewModel.userLogin == null) {
        //   return Center(
        //     child: LoadingAnimationWidget.threeRotatingDots(
        //       color: AppColor.primaryColor,
        //       size: 50,
        //     ),
        //   );
        // }
        return BasePage(
          title: 'Thông tin',
          showLogout: true,
          body: viewModel.isBusy
              ? Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                    color: AppColor.primaryColor,
                    size: 50,
                  ),
                )
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Số người đã checkin",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: AppFontSize.sizeLarge),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${widget.indexViewModel.usersViewModel.checkInUser.length}',
                                style: TextStyle(
                                    fontSize: AppFontSize.sizeTitle,
                                    color: AppColor.successQRCode,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '/',
                                style: TextStyle(
                                    fontSize: AppFontSize.sizeTitle,
                                    color: AppColor.darkColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    '${widget.indexViewModel.usersViewModel.lstUsers.length}',
                                style: TextStyle(
                                    fontSize: AppFontSize.sizeTitle,
                                    color: AppColor.selectColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mã sự kiện',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFontSize.sizeSmall,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                  color: AppColor.extraColor.withOpacity(0.85),
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ListTile(
                                      leading: const Icon(Icons.account_circle),
                                      title: Text(
                                          '${AppSP.get(AppSPKey.tenTK)}'))),
                              SizedBox(height: 20),
                              Text(
                                'Tên sự kiện',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFontSize.sizeSmall,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                color: AppColor.extraColor.withOpacity(0.85),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                    leading: const Icon(
                                        Icons.label_important_outline_sharp),
                                    title: viewModel
                                            .userLogin!.tenSukien!.isEmpty
                                        ? LoadingAnimationWidget
                                            .threeRotatingDots(
                                            color: AppColor.primaryColor,
                                            size: 50,
                                          )
                                        : Text(
                                            viewModel.userLogin!.tenSukien!)),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Thời gian checkin',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFontSize.sizeSmall,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                color: AppColor.extraColor.withOpacity(0.85),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(
                                          Icons.calendar_month_outlined),
                                      title: Text(
                                          viewModel.userLogin!.ngayDienRa!),
                                    ),
                                    const Divider(height: 1),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Địa điểm',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFontSize.sizeSmall,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                color: AppColor.extraColor.withOpacity(0.85),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.location_on),
                                      title: Text(
                                          viewModel.userLogin!.diaDiem ?? ''),
                                    ),
                                    const Divider(height: 1),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       'Số lượng field: ${nonNullFields.length}',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: AppFontSize.sizeSmall,
                              //       ),
                              //     ),
                              //     IconButton(
                              //       icon: Icon(isExpanded
                              //           ? Icons.expand_less
                              //           : Icons.expand_more),
                              //       onPressed: () {
                              //         setState(() {
                              //           isExpanded =
                              //               !isExpanded; // Thay đổi trạng thái mở/đóng
                              //         });
                              //       },
                              //     ),
                              //   ],
                              // ),
                              // AnimatedCrossFade(
                              //   firstChild:
                              //       Container(), // Không hiển thị gì khi đóng
                              //   secondChild: Column(
                              //     children: nonNullFields.map((field) {
                              //       return Card(
                              //         color:
                              //             AppColor.extraColor.withOpacity(0.85),
                              //         elevation: 4.0,
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(10.0),
                              //         ),
                              //         margin: const EdgeInsets.symmetric(
                              //             vertical: 5),
                              //         child: ListTile(
                              //           title: Text('${field['value']}'),
                              //         ),
                              //       );
                              //     }).toList(),
                              //   ),
                              //   crossFadeState: isExpanded
                              //       ? CrossFadeState.showSecond
                              //       : CrossFadeState.showFirst,
                              //   duration: Duration(milliseconds: 200),
                              // ),
                              // SizedBox(
                              //   height: 30,
                              // ),
                              Center(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: ButtonCustom(
                                    onPressed: () {
                                      viewModel.showLogOut(context);
                                    },
                                    nameButton: 'Đăng xuất',
                                    color: AppColor.primaryColor,
                                    colorName: AppColor.extraColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
