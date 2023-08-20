import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hrd_app/utils/constant.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<Either<String, Response>> changePass(
      {required String current,
      required String newpass,
      required String confirm}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');

    try {
      final response = await put(Uri.parse('$API_URL/changepass'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "current_password": current,
            "new_password": newpass,
            "confirm_password": confirm
          }));

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
