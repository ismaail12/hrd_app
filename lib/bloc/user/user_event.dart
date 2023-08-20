part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserChangePass extends UserEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const UserChangePass(
      {required this.newPassword,
      required this.confirmPassword,
      required this.oldPassword});

  @override
  List<Object> get props => [newPassword, confirmPassword, oldPassword];
}
