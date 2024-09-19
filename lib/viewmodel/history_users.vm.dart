import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:klok/app/app_sp.dart';
import 'package:klok/app/app_sp_key.dart';
import 'package:klok/app/app_string.dart';
import 'package:klok/model/login.model.dart';
import 'package:klok/model/user.model.dart';
import 'package:klok/requests/history_user.requets.dart';
import 'package:klok/viewmodel/index.vm.dart';
import 'package:klok/viewmodel/qr_code.vm.dart';

import 'package:klok/views/history/widgets/detail.ticket.widget.dart';
import 'package:stacked/stacked.dart';

class UsersViewModel extends BaseViewModel {
  late BuildContext viewContext;
  late Users detailUser;
  UserRequest userRequest = UserRequest();
  late IndexViewModel indexViewModel;
  // final apiService = ApiService();
  List<Users> lstUsers = [];
  List<Users> checkInUser = [];
  List<Users> notCheckIntUser = [];
  List<Users> filteredUsers = [];
  List<Users> filteredCheckInUser = [];
  List<Users> filteredNotCheckIntUser = [];
  TextEditingController search = TextEditingController();
  String searchQuery = '';
  getUsers() async {
    setBusy(true);
    lstUsers = await userRequest.getListUser(
        idSuKien: AppSP.get(AppSPKey.idSuKien), tinhTrang: 2);
    checkInUser = await userRequest.getListUser(
        idSuKien: AppSP.get(AppSPKey.idSuKien), tinhTrang: 1);
    notCheckIntUser = await userRequest.getListUser(
        idSuKien: AppSP.get(AppSPKey.idSuKien), tinhTrang: 0);
    print('All users: ${lstUsers.length}');
    print('Checked-in users: ${checkInUser.length}');
    print('Not checked-in users: ${notCheckIntUser.length}');
    filterUsers();
    setBusy(false);
    notifyListeners();
  }

  void filterUsers() {
    filteredUsers = lstUsers.where((user) {
      final query = searchQuery.toLowerCase();
      return user.field2!.toLowerCase().contains(query) ||
          user.maQR.toLowerCase().contains(query);
    }).toList();

    filteredCheckInUser =
        filteredUsers.where((user) => user.isCheckin).toList();
    filteredNotCheckIntUser =
        filteredUsers.where((user) => !user.isCheckin).toList();

    notifyListeners();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    filterUsers(); // Update filtered lists based on the search query
  }

  nextDetailTicket() async {
    Navigator.push(
        viewContext,
        MaterialPageRoute(
            builder: (context) => DetailTicket(
                  user: detailUser,
                  usersViewModel: this,
                )));
  }
}
