

import 'package:dio/dio.dart';
import 'package:klok/constants/api.dart';
import 'package:klok/model/login.model.dart';
import 'package:klok/services/api_services.dart';

class LoginRequest {
  final Dio dio = Dio();

  Future<Login?> getUsers({required String tenSK, required String mkSK}) async {
    final Map<String, dynamic> body = {
      "MaSuKien": tenSK,
      "MatKhau": mkSK,
    };
    final response = await ApiService().Login(
      '${Api.hostApi}${Api.login}',
      queryParameters: body,
    );
    print('${Api.hostApi}${Api.login}');
    print("User: ${response.data}");

    if (response.statusCode == 200) {
      final data = response.data;

      if (data != null) {
        final status = data['Status'];

        if (status == 0) {
          print(
              'Login failed: Tài khoản không tồn tại hoặc thông tin đăng nhập không chính xác');
          return null;
        } else {
          // Chuyển đổi dữ liệu JSON thành đối tượng Login
          final login = Login.fromJson(data);
          return login;
        }
      } else {
        print('Không nhận được dữ liệu');
        return null;
      }
    } else {
      print('Đăng nhập thất bại: Mã trạng thái ${response.statusCode}');
      return null;
    }
  }

  Future<Login?> login({required String tenSK, required String mkSK}) async {
    final Map<String, dynamic> body = {
      "MaSuKien": tenSK,
      "MatKhau": mkSK,
    };
    final response = await ApiService().Login(
      '${Api.hostApi}${Api.login}',
      queryParameters: body,
    );
    print('${Api.hostApi}${Api.login}');
    print("UserLoginssss: ${response.data}");

    if (response.statusCode == 200) {
      final data = response.data;

      if (data != null) {
        final status = data['Status'];

        if (status == 0) {
          print('${data}');
          print(
              'Login failed: Tài khoản không tồn tại hoặc thông tin đăng nhập không chính xác');
          return null;
        } else {
          // Chuyển đổi dữ liệu JSON thành đối tượng Login
          final login = Login.fromJson(data);

          return login;
        }
      } else {
        print('Không nhận được dữ liệu');
        return null;
      }
    } else {
      print('Đăng nhập thất bại: Mã trạng thái ${response.statusCode}');
      return null;
    }
  }
}
