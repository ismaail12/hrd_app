part of 'user_bloc.dart';

enum UserStatus { initial, success, loading, error }

enum InternetStatus { connected, disconnected }

class UserState extends Equatable {
  final UserStatus status;
  String? message;
  UserState({required this.status, this.message});

  @override
  List<Object> get props => [status];
}
