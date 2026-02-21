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
      namaLengkap: json['nama_lengkap'] ?? '',
      jabatan: json['jabatan'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      namaGolongan: json['nama_golongan'] ?? '',
      namaPangkat: json['nama_pangkat'] ?? '',
      unitKerja: json['unit_kerja'] ?? '',
      skpd: json['skpd'] ?? '',
      alamatLengkap: json['alamat_lengkap'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'nama_lengkap': namaLengkap,
      'jabatan': jabatan,
      'jenis_kelamin': jenisKelamin,
      'nama_golongan': namaGolongan,
      'nama_pangkat': namaPangkat,
      'unit_kerja': unitKerja,
      'skpd': skpd,
      'alamat_lengkap': alamatLengkap,
    };
  }
}
