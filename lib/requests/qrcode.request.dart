import 'package:dio/dio.dart';
import 'package:klok/constants/api.dart';
import 'package:klok/model/user.model.dart';
import 'package:klok/services/api_services.dart';

class QRCodeRequest {
  final Dio dio = Dio();

  Future<Users?> checkIn(
      {required String idSuKien, required String maQR}) async {
    final Map<String, dynamic> body = {
      'idSuKien': idSuKien,
      'MaThamDu': maQR,
    };
    try {
      final response = await ApiService().QrCode(
        '${Api.hostApi}${Api.checkIn}',
        queryParameters: body,
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print(response.data['Status']);
        if (data["Status"] == 1) {
          print('Check-in thành công: ${data['Status']}');
          return Users.fromJson(data);
        } else if (data["Status"] == 2) {
          print('Đã checkin: ${data['Status']}');
          return null;
        } else {
          print('Check-in không thành công: ${data['Status']}');
          return null;
        }
      } else {
        print('Check-in failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('zxczxc: $e');
      return null;
    }
  }

  Future<Users?> getUser(
      {required String maQR, required String idSuKien}) async {
    final Map<String, dynamic> body = {
      'idSuKien': idSuKien,
      "MaThamDu": maQR,
    };
    try {
      final response = await ApiService().getUsers(
        '${Api.hostApi}${Api.infoUser}',
        queryParameters: body,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['Status'] == 0) {
          print("User không tồn tại");
          return null;
        }
        final qrCodeRespnse = Users.fromJson(data);
        return qrCodeRespnse;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('xxxxxxxxError: $e');
      return null;
    }
  }
}
