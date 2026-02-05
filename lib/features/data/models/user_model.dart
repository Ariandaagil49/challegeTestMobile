import 'package:crud_software/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.nip,
    required super.namaLengkap,
    required super.jabatan,
    required super.jenisKelamin,
    required super.namaGolongan,
    required super.namaPangkat,
    required super.unitKerja,
    required super.skpd,
    required super.alamatLengkap,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      nip: json['nip'] ?? '',
      namaLengkap: json['namaLengkap'] ?? '',
      jabatan: json['jabatan'] ?? '',
      jenisKelamin: json['jenisKelamin'] ?? '',
      namaGolongan: json['namaGolongan'] ?? '',
      namaPangkat: json['namaPangkat'] ?? '',
      unitKerja: json['unitKerja'] ?? '',
      skpd: json['skpd'] ?? '',
      alamatLengkap: json['alamatLengkap'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'namaLengkap': namaLengkap,
      'jabatan': jabatan,
      'jenisKelamin': jenisKelamin,
      'namaGolongan': namaGolongan,
      'namaPangkat': namaPangkat,
      'unitKerja': unitKerja,
      'skpd': skpd,
      'alamatLengkap': alamatLengkap,
    };
  }
}
