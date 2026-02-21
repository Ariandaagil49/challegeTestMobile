import 'package:http/http.dart' as http;

import '../features/data/datasources/user_remote_data_source.dart';
import '../features/data/datasources/user_local_data_source.dart';
import '../features/data/repositories/user_repository_impl.dart';

import '../features/domain/repositories/user_repository.dart';
import '../features/domain/usecases/get_users_usecase.dart';
import '../features/domain/usecases/add_user_usecase.dart';
import '../features/domain/usecases/update_user_usecase.dart';
import '../features/domain/usecases/delete_user_usecase.dart';

import '../features/presentation/bloc/user_cubit.dart';

class Injector {
  static late http.Client httpClient;

  static late UserRemoteDataSource remoteDataSource;
  static late UserLocalDataSource localDataSource;

  static late UserRepository userRepository;

  static late GetUsersUsecase getUsersUsecase;
  static late AddUserUsecase addUserUsecase;
  static late UpdateUserUsecase updateUserUsecase;
  static late DeleteUserUsecase deleteUserUsecase;

  static late UserCubit userCubit;

  static Future<void> init() async {
    httpClient = http.Client();

    remoteDataSource = UserRemoteDataSourceImpl(client: httpClient);

    localDataSource = UserLocalDataSource();

    userRepository = UserRepositoryImpl(
      remote: remoteDataSource,
      local: localDataSource,
    );

    getUsersUsecase = GetUsersUsecase(userRepository);
    addUserUsecase = AddUserUsecase(userRepository);
    updateUserUsecase = UpdateUserUsecase(userRepository);
    deleteUserUsecase = DeleteUserUsecase(userRepository);

    userCubit = UserCubit(
      getUsersUsecase: getUsersUsecase,
      addUserUsecase: addUserUsecase,
      updateUserUsecase: updateUserUsecase,
      deleteUserUsecase: deleteUserUsecase,
    );
  }
}
