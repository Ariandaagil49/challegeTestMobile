import 'package:crud_software/features/domain/entities/user_entity.dart';
import 'package:crud_software/features/domain/repositories/user_repository.dart';

class AddUserUsecase {
  final UserRepository repository;
  AddUserUsecase({required this.repository});
  Future<UserEntity> execute(UserEntity user) async {
    return await repository.addUser(user);
  }
}
