import 'package:dio/dio.dart';
import 'package:klok/constants/api.dart';
import 'package:klok/model/user.model.dart';
import 'package:klok/services/api_services.dart';

class UserRequest {
  Dio dio = Dio();

  Future<List<Users>> getListUser(
      {required int tinhTrang, required String idSuKien}) async {
    List<Users> lstUsers = [];
    final Map<String, dynamic> body = {
      "idSuKien": idSuKien,
      "TinhTrang": tinhTrang,
    };
    try {
      // Thực hiện yêu cầu POST với query parameters
      final response = await ApiService()
          .getListUsers('${Api.hostApi}${Api.Users}', queryParameters: body);

      print('data : ${response.data['LNguoiThamDu']}');

      // Kiểm tra nếu 'status' trong phản hồi là 0
      if (response.data is Map && response.data['status'] == 0) {
        print('Người dùng đã được quét hết.');
      } else if (response.statusCode == 200) {
        if (response.data['LNguoiThamDu'] is List) {
          List<dynamic> data = response.data['LNguoiThamDu'];
          lstUsers = data.map((json) => Users.fromJson(json)).toList();
        } else {
          print('Người dùng đã được quét hết.');
        }
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      // Xử lý ngoại lệ
      print('Error: $e');
    }

    return lstUsers;
  }
}
