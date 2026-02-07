// import '../../domain/entities/user_entity.dart';
// import '../../domain/repositories/user_repository.dart';
// import '../datasources/user_remote_data_source.dart';
// import '../models/user_model.dart';

// class UserRepositoryImpl implements UserRepository {
//   final UserRemoteDataSource remote;

//   UserRepositoryImpl(this.remote);

//   @override
//   Future<List<UserEntity>> getUsers() {
//     return remote.getUsers();
//   }

//   @override
//   Future<void> addUser(UserEntity user) {
//     return remote.addUser(_mapToModel(user));
//   }

//   @override
//   Future<void> updateUser(String id, UserEntity user) {
//     return remote.updateUser(id, _mapToModel(user));
//   }

//   @override
//   Future<void> deleteUser(String id) {
//     return remote.deleteUser(id);
//   }

//   UserModel _mapToModel(UserEntity user) {
//     return UserModel(
//       id: user.id,
//       nip: user.nip,
//       namaLengkap: user.namaLengkap,
//       jabatan: user.jabatan,
//       jenisKelamin: user.jenisKelamin,
//       namaGolongan: user.namaGolongan,
//       namaPangkat: user.namaPangkat,
//       unitKerja: user.unitKerja,
//       skpd: user.skpd,
//       alamatLengkap: user.alamatLengkap,
//     );
//   }
// }import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource local;

  UserRepositoryImpl({required this.local});

  @override
  Future<List<UserEntity>> getUsers() async {
    final raw = await local.loadRawUsers();
    return raw.map(UserEntity.fromJson).toList();
  }

  @override
  Future<void> addUser(UserEntity user) async {
    final list = await getUsers();

    final newUser = user.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    final updated = [newUser, ...list];
    await local.saveRawUsers(updated.map((e) => e.toJson()).toList());
  }

  @override
  Future<void> deleteUser(String id) async {
    final list = await getUsers();
    final updated = list.where((u) => u.id != id).toList();
    await local.saveRawUsers(updated.map((e) => e.toJson()).toList());
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final list = await getUsers();
    final updated = list.map((u) => u.id == user.id ? user : u).toList();
    await local.saveRawUsers(updated.map((e) => e.toJson()).toList());
  }
}
