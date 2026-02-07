import 'package:http/http.dart' as http;

import '../features/data/datasources/user_local_data_source.dart';
import '../features/data/repositories/user_repository_impl.dart';
import '../features/domain/usecases/add_user_usecase.dart';
import '../features/domain/usecases/delete_user_usecase.dart';
import '../features/domain/usecases/get_users_usecase.dart';
import '../features/domain/usecases/update_user_usecase.dart';
import '../features/presentation/bloc/user_cubit.dart';

class Injector {
  static final Injector _instance = Injector._internal();
  factory Injector() => _instance;
  Injector._internal();

  late http.Client httpClient;

  late UserLocalDataSource userLocalDataSource;
  late UserRepositoryImpl userRepository;

  late GetUsersUsecase getUsersUsecase;
  late AddUserUsecase addUserUsecase;
  late DeleteUserUsecase deleteUserUsecase;
  late UpdateUserUsecase updateUserUsecase;

  late UserCubit userCubit;

  void init() {
    httpClient = http.Client();

    userLocalDataSource = UserLocalDataSource();
    userRepository = UserRepositoryImpl(local: userLocalDataSource);

    getUsersUsecase = GetUsersUsecase(userRepository);
    addUserUsecase = AddUserUsecase(userRepository);
    deleteUserUsecase = DeleteUserUsecase(userRepository);
    updateUserUsecase = UpdateUserUsecase(userRepository);

    userCubit = UserCubit(
      getUsersUsecase: getUsersUsecase,
      addUserUsecase: addUserUsecase,
      deleteUserUsecase: deleteUserUsecase,
      updateUserUsecase: updateUserUsecase,
    );
  }
}
