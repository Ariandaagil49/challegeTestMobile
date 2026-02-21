import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/add_user_usecase.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/update_user_usecase.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsersUsecase getUsersUsecase;
  final AddUserUsecase addUserUsecase;
  final DeleteUserUsecase deleteUserUsecase;
  final UpdateUserUsecase updateUserUsecase;

  UserCubit({
    required this.getUsersUsecase,
    required this.addUserUsecase,
    required this.deleteUserUsecase,
    required this.updateUserUsecase,
  }) : super(UserState.initial());

  Future<void> fetchUsers() async {
    emit(state.copyWith(status: UserStatus.loading, clearMessage: true));
    try {
      final users = await getUsersUsecase.execute();
      emit(state.copyWith(status: UserStatus.success, users: users));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.failure, message: e.toString()));
      rethrow;
    }
  }

  Future<void> addUser(UserEntity user) async {
    emit(state.copyWith(status: UserStatus.loading, clearMessage: true));
    try {
      await addUserUsecase.execute(user);
      await fetchUsers();
      emit(state.copyWith(message: 'Data tersimpan'));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.failure, message: e.toString()));
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    emit(state.copyWith(status: UserStatus.loading, clearMessage: true));
    try {
      await deleteUserUsecase.execute(id);
      await fetchUsers();
      emit(state.copyWith(message: 'Data terhapus'));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.failure, message: e.toString()));
      rethrow;
    }
  }

  Future<void> updateUser(UserEntity user) async {
    emit(state.copyWith(status: UserStatus.loading, clearMessage: true));
    try {
      await updateUserUsecase.execute(user);
      await fetchUsers();
      emit(state.copyWith(message: 'Data diperbarui'));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.failure, message: e.toString()));
      rethrow;
    }
  }

  void clearMessage() => emit(state.copyWith(clearMessage: true));
}
