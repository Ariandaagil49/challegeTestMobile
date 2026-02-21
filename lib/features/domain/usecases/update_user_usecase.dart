import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UpdateUserUsecase {
  final UserRepository repo;
  UpdateUserUsecase(this.repo);

  Future<void> execute(UserEntity user) => repo.updateUser(user);
}
