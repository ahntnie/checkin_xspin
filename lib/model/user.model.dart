class Users {
  String maQR; // Non-nullable, required
  bool isCheckin; // Non-nullable, required
  String idNguoiThamDu;
  String? thoiDiemCheckin; // Nullable string
  String? field2; // Nullable string
  String? field3; // Nullable string
  String? field4; // Nullable string
  String? field5; // Nullable string
  String? field6; // Nullable string
  String? field7; // Nullable string
  String? field8; // Nullable string
  String? field9; // Nullable string
  String? field10; // Nullable string
  String? field11; // Nullable string
  String? field12; // Nullable string
  String? field13; // Nullable string
  String? field14; // Nullable string
  String? field15; // Nullable string

  Users({
    required this.maQR,
    required this.isCheckin,
    required this.idNguoiThamDu,
    this.thoiDiemCheckin,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.field6,
    this.field7,
    this.field8,
    this.field9,
    this.field10,
    this.field11,
    this.field12,
    this.field13,
    this.field14,
    this.field15,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      maQR: json['MaThamDu'] ?? '', // Non-nullable, required
      idNguoiThamDu: json['idNguoiThamDu'] ?? '',
      isCheckin: json['isCheckin'] == "True", // Non-nullable, required
      thoiDiemCheckin: json['ThoiDiemCheckin'], // Nullable
      field2: json['Field2'], // Nullable
      field3: json['Field3'], // Nullable
      field4: json['Field4'], // Nullable
      field5: json['Field5'], // Nullable
      field6: json['Field6'], // Nullable
      field7: json['Field7'], // Nullable
      field8: json['Field8'], // Nullable
      field9: json['Field9'], // Nullable
      field10: json['Field10'], // Nullable
      field11: json['Field11'], // Nullable
      field12: json['Field12'], // Nullable
      field13: json['Field13'], // Nullable
      field14: json['Field14'], // Nullable
      field15: json['Field15'], // Nullable
    );
  }

  bool searchName(String field2) {
    return this.field2?.toLowerCase().contains(field2.toLowerCase()) ?? false;
  }

  bool searchQR(String qr) {
    return maQR.toLowerCase().contains(qr.toLowerCase());
  }
}
