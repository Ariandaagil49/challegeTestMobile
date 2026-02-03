import 'package:crud_software/features/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
  Future<UserEntity> addUser(UserEntity user);
}
