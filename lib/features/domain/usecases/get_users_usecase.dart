import 'package:crud_software/features/domain/entities/user_entity.dart';
import 'package:crud_software/features/domain/repositories/user_repository.dart';

class GetUsersUsecase {
  final UserRepository repository;
  GetUsersUsecase({required this.repository});
  Future<List<UserEntity>> execute() async {
    return await repository.getUsers();
  }
}
