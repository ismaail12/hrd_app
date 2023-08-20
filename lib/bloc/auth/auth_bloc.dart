// ignore_for_file: avoid_print

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hrd_app/bloc/internet/internet_bloc.dart';
import 'package:hrd_app/data/repository/auth_repository.dart';
import 'package:hrd_app/data/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();
  final InternetBloc internetBloc;
  late final StreamSubscription internetSubscription;
  bool internetConnection = false;

  SharedPreferences? sharedPreferences;

  AuthBloc({required this.internetBloc})
      : super(AuthState(status: AuthStatus.initial)) {
    on<AuthInitial>(_onAuthInitial);
    on<AuthLogin>(_onAuthLogin);
    on<AuthLogout>(_onAuthLogout);
    _getSrefInstance();
    internetSubscription =
        internetBloc.stream.listen((InternetState internetState) {
      internetState is Connected
          ? internetConnection = true
          : internetConnection = false;
    });
  }

  Future<void> _getSrefInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> _onAuthInitial(
      AuthInitial event, Emitter<AuthState> emit) async {
    if (state.status != AuthStatus.authenticated) {
      emit(AuthState(status: AuthStatus.onLogin));
    }
  }

  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthState(status: AuthStatus.loading));

    if (!internetConnection) {
      emit(AuthState(
          status: AuthStatus.error,
          message: 'Periksa kembali jaringan internet anda'));
      return;
    }

    final response = await authRepository.login(event.email, event.password);
    response.fold((left) {
      sharedPreferences?.setString('token', left.data.token);

      emit(AuthState(
          status: AuthStatus.authenticated,
          user: left.data.user,
          token: left.data.token,
          message: 'Berhasil login'));
    }, (right) {
      emit(AuthState(status: AuthStatus.error, message: right));
    });
  }

  void _clearHydrated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    if (!internetConnection) {
      emit(AuthState(
          status: AuthStatus.error,
          message: 'Periksa kembali jaringan internet anda'));
      return;
    }
    sharedPreferences?.remove('token');
    await authRepository.logout(event.token);
    _clearHydrated();
    emit(AuthState(status: AuthStatus.onLogin));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
