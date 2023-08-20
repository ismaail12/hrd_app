import 'package:intl/intl.dart';

class Event {
  final int id;
  final String name;
  final String type;
  final DateTime createdAt;
  final dynamic clockout;
  final dynamic info;

  Event({
    required this.id,
    required this.name,
    required this.type,
    required this.createdAt,
    this.clockout,
    this.info,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      clockout: json['clockout'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'created_at': DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'")
          .format(createdAt.toUtc()),
      'clockout': clockout,
      'info': info,
    };
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  String toString() {
    return capitalize(type);
  }
}
