part of 'auth_bloc.dart';

enum AuthStatus { initial, onLogin, loading, authenticated, error }

enum InternetStatus { connected, disconnected }

// ignore: must_be_immutable
class AuthState extends Equatable {
  User? user;
  String? message;
  String? token;
  final AuthStatus status;


  AuthState({
    required this.status,
    this.user,
    this.token,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'status': status.name,
      'message': message,
      'token': token,

    };
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      user: User.fromJson(json['user']),
      message: json['message'],
      token: json['token'],
      status: AuthStatus.values.firstWhere(
        (element) => element.name.toString() == json['status'],
      ),

    );
  }

  @override
  List<Object?> get props => [status, user, message];
}
