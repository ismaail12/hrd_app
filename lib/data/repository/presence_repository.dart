// ignore_for_file: unused_import

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hrd_app/data/response/presence_response.dart';
import 'package:http/http.dart';
import 'package:hrd_app/data/model/event.dart';
import 'package:hrd_app/data/request/clockin_request.dart';
import 'package:hrd_app/data/request/clockout_request.dart';

import 'package:hrd_app/utils/constant.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PresenceRepository {
  Future<Either<Response, PresencesResponse>> todayPresence() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');

    final response = await get(Uri.parse('$API_URL/presences/today'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return Right(PresencesResponse.fromJson(jsonDecode(response.body)));
    } else {
      return Left(response);
    }
  }

  Future<Either<String, Map<DateTime, List<Event>>>>
      fetchAndTransformEvents() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');

    try {
      final response = await get(
        Uri.parse('$API_URL/presences'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> data = jsonData['data'];

        Map<DateTime, List<Event>> dateTimeMap = {};

        for (var item in data) {
          String createdAt = item['created_at'].split('T')[0];
          DateTime date = DateTime.parse(createdAt);
          List<Event> events = dateTimeMap[date] ?? [];
          events.add(Event.fromJson(item));
          dateTimeMap[date] = events;
        }
        return Right(dateTimeMap);
      } else {
        return const Left('Terjadi kesalahan');
      }
    } catch (e) {
      return const Left(
          'Gagal mendapatkan data presensi, Periksa jaringan internet anda');
    }
  }
}
