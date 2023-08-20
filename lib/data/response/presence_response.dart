// To parse this JSON data, do
//
//     final presencesResponse = presencesResposeFromJsnon(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PresencesResponse {
  final String message;
  final Data data;

  PresencesResponse({
    required this.message,
    required this.data,
  });

  factory PresencesResponse.fromRawJson(String str) =>
      PresencesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PresencesResponse.fromJson(Map<String, dynamic> json) =>
      PresencesResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final List<String> presenced;
  final List<String> notPresenced;

  Data({
    required this.presenced,
    required this.notPresenced,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        presenced: List<String>.from(json["presenced"].map((x) => x)),
        notPresenced: List<String>.from(json["not_presenced"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "presenced": List<dynamic>.from(presenced.map((x) => x)),
        "not_presenced": List<dynamic>.from(notPresenced.map((x) => x)),
      };
}
