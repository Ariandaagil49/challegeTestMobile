import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;

  UserRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<UserEntity>> getUsers() async {
    try {
      final remoteUsers = await remote.getUsers();

      await local.saveRawUsers(remoteUsers.map((e) => e.toJson()).toList());

      return remoteUsers;
    } catch (_) {
      final raw = await local.loadRawUsers();
      return raw.map(UserEntity.fromJson).toList();
    }
  }

  @override
  Future<void> addUser(UserEntity user) async {
    final model = UserModel(
      id: user.id,
      nip: user.nip,
      namaLengkap: user.namaLengkap,
      jabatan: user.jabatan,
      jenisKelamin: user.jenisKelamin,
      namaGolongan: user.namaGolongan,
      namaPangkat: user.namaPangkat,
      unitKerja: user.unitKerja,
      skpd: user.skpd,
      alamatLengkap: user.alamatLengkap,
    );

    await remote.addUser(model);
    await getUsers();
  }

  @override
  Future<void> deleteUser(String id) async {
    await remote.deleteUser(id);
    await getUsers();
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final model = UserModel(
      id: user.id,
      nip: user.nip,
      namaLengkap: user.namaLengkap,
      jabatan: user.jabatan,
      jenisKelamin: user.jenisKelamin,
      namaGolongan: user.namaGolongan,
      namaPangkat: user.namaPangkat,
      unitKerja: user.unitKerja,
      skpd: user.skpd,
      alamatLengkap: user.alamatLengkap,
    );

    await remote.updateUser(user.id, model);
    await getUsers();
  }
}
