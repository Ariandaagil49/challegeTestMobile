import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String nip;
  final String namaLengkap;
  final String jabatan;
  final String jenisKelamin;
  final String namaGolongan;
  final String namaPangkat;
  final String unitKerja;
  final String skpd;
  final String alamatLengkap;

  const UserEntity({
    required this.id,
    required this.nip,
    required this.namaLengkap,
    required this.jabatan,
    required this.jenisKelamin,
    required this.namaGolongan,
    required this.namaPangkat,
    required this.unitKerja,
    required this.skpd,
    required this.alamatLengkap,
  });

  UserEntity copyWith({
    String? id,
    String? nip,
    String? namaLengkap,
    String? jabatan,
    String? jenisKelamin,
    String? namaGolongan,
    String? namaPangkat,
    String? unitKerja,
    String? skpd,
    String? alamatLengkap,
  }) {
    return UserEntity(
      id: id ?? this.id,
      nip: nip ?? this.nip,
      namaLengkap: namaLengkap ?? this.namaLengkap,
      jabatan: jabatan ?? this.jabatan,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      namaGolongan: namaGolongan ?? this.namaGolongan,
      namaPangkat: namaPangkat ?? this.namaPangkat,
      unitKerja: unitKerja ?? this.unitKerja,
      skpd: skpd ?? this.skpd,
      alamatLengkap: alamatLengkap ?? this.alamatLengkap,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: (json['id'] ?? '').toString(),
      nip: (json['nip'] ?? '').toString(),
      namaLengkap: (json['namaLengkap'] ?? json['nama_lengkap'] ?? '')
          .toString(),
      jabatan: (json['jabatan'] ?? '').toString(),
      jenisKelamin: (json['jenisKelamin'] ?? json['jenis_kelamin'] ?? '')
          .toString(),
      namaGolongan: (json['namaGolongan'] ?? json['nama_golongan'] ?? '')
          .toString(),
      namaPangkat: (json['namaPangkat'] ?? json['nama_pangkat'] ?? '')
          .toString(),
      unitKerja: (json['unitKerja'] ?? json['unit_kerja'] ?? '').toString(),
      skpd: (json['skpd'] ?? '').toString(),
      alamatLengkap: (json['alamatLengkap'] ?? json['alamat_lengkap'] ?? '')
          .toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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

  @override
  List<Object?> get props => [
    id,
    nip,
    namaLengkap,
    jabatan,
    jenisKelamin,
    namaGolongan,
    namaPangkat,
    unitKerja,
    skpd,
    alamatLengkap,
  ];
}
