import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUsersUsecase {
  final UserRepository repo;
  GetUsersUsecase(this.repo);

  Future<List<UserEntity>> execute() => repo.getUsers();
}
