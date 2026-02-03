import 'package:crud_software/features/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
  Future<void> addUser(UserEntity user);
  Future<void> updateUser(String id, UserEntity user);
  Future<void> deleteUser(String id);
}
