import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

enum UserStatus { initial, loading, success, failure }

class UserState extends Equatable {
  final UserStatus status;
  final List<UserEntity> users;
  final String? message;

  const UserState({required this.status, required this.users, this.message});

  factory UserState.initial() {
    return const UserState(
      status: UserStatus.initial,
      users: [],
      message: null,
    );
  }

  UserState copyWith({
    UserStatus? status,
    List<UserEntity>? users,
    String? message,
    bool clearMessage = false,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [status, users, message];
}
