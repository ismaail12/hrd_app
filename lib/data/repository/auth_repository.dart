// ignore_for_file: unused_import

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:hrd_app/data/response/login_response.dart';

import 'package:hrd_app/utils/constant.dart';

class AuthRepository {
  Future<Either<LoginResponse, String>> login(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      Response response = await post(Uri.parse('$API_URL/login'),
          body: {'email': email, 'password': password, 'role': 'hrd'});
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(responseJson);

        return Left(loginResponse);
      } else if (response.statusCode == 401) {
        return const Right('Email dan password tidak cocok');
      } else if (response.statusCode == 302) {
        return const Right('Format email salah');
      } else {
        return const Right('Terjadi kesalahan');
      }
    } catch (e) {
      return const Right('Terjadi kesalahan');
    }
  }

  Future<void> logout(String token) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    await post(Uri.parse('$API_URL/logout'),
        headers: {'Authorization': 'Bearer $token'});
  }
}
