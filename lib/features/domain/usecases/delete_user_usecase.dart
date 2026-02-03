import 'package:crud_software/features/domain/repositories/user_repository.dart';

class DeleteUserUsecase {
  final UserRepository repository;
  DeleteUserUsecase(this.repository);

  Future<void> call(String id) {
    return repository.deleteUser(id);
  }
}
