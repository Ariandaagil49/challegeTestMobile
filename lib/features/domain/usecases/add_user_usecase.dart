import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class AddUserUsecase {
  final UserRepository repo;
  AddUserUsecase(this.repo);

  Future<void> execute(UserEntity user) => repo.addUser(user);
}
