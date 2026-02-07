import '../repositories/user_repository.dart';

class DeleteUserUsecase {
  final UserRepository repo;
  DeleteUserUsecase(this.repo);

  Future<void> execute(String id) => repo.deleteUser(id);
}
