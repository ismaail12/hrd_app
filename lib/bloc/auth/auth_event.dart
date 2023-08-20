part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthInitial extends AuthEvent {
  const AuthInitial();
  @override
  List<Object> get props => [];
}

class AuthLogout extends AuthEvent {
  final String token;
  const AuthLogout(this.token);

  @override
  List<Object> get props => [token];
}
