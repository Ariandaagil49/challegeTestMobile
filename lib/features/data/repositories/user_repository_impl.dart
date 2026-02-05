import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;

  UserRepositoryImpl(this.remote);

  @override
  Future<List<UserEntity>> getUsers() {
    return remote.getUsers();
  }

  @override
  Future<void> addUser(UserEntity user) {
    return remote.addUser(_mapToModel(user));
  }

  @override
  Future<void> updateUser(String id, UserEntity user) {
    return remote.updateUser(id, _mapToModel(user));
  }

  @override
  Future<void> deleteUser(String id) {
    return remote.deleteUser(id);
  }

  UserModel _mapToModel(UserEntity user) {
    return UserModel(
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
  }
}
