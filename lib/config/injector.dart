import 'package:http/http.dart' as http;

import '../features/data/datasources/user_remote_data_source.dart';
import '../features/domain/repositories/user_repository.dart';
import '../features/domain/usecases/add_user_usecase.dart';
import '../features/domain/usecases/delete_user_usecase.dart';
import '../features/domain/usecases/get_users_usecase.dart';

class Injector {
  static final Injector _instance = Injector._internal();
  factory Injector() => _instance;
  Injector._internal();

  late http.Client httpClient;
  late UserRemoteDataSource userRemoteDataSource;
  late UserRepository userRepository;

  late GetUsersUsecase getUsersUsecase;
  late AddUserUsecase addUserUsecase;
  late DeleteUserUsecase deleteUserUsecase;

  // late UserCubit userCubit;

  // void init() {
  //   httpClient = http.Client();

  //   userRemoteDataSource = UserRemoteDataSourceImpl(client: httpClient);

  //   userRepository = UserRepositoryImpl(remoteDataSource: userRemoteDataSource);

  //   getUsersUsecase = GetUsersUsecase(repository: userRepository);
  //   addUserUsecase = AddUserUsecase(repository: userRepository);
  //   deleteUserUsecase = DeleteUserUsecase(repository: userRepository);

  //   userCubit = UserCubit(
  //     getUsersUsecase: getUsersUsecase,
  //     addUserUsecase: addUserUsecase,
  //     deleteUserUsecase: deleteUserUsecase,
  //   );
  // }
}
