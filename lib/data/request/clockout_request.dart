// To parse this JSON data, do
//
//     final clockOutRequest = clockOutRequestFromJson(jsonString);

import 'dart:convert';

class ClockOutRequest {
    int id;
    double coLong;
    double coLat;

    ClockOutRequest({
        required this.id,
        required this.coLong,
        required this.coLat,
    });

    ClockOutRequest copyWith({
        int? id,
        double? coLong,
        double? coLat,
    }) => 
        ClockOutRequest(
            id: id ?? this.id,
            coLong: coLong ?? this.coLong,
            coLat: coLat ?? this.coLat,
        );

    factory ClockOutRequest.fromRawJson(String str) => ClockOutRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClockOutRequest.fromJson(Map<String, dynamic> json) => ClockOutRequest(
        id: json["id"],
        coLong: json["co_long"]?.toDouble(),
        coLat: json["co_lat"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "co_long": coLong,
        "co_lat": coLat,
    };
}
