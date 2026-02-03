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
