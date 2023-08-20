part of 'presence_bloc.dart';

enum ClockedStatus { initial, loading, success, error }

// ignore: must_be_immutable
class PresenceState extends Equatable {
  ClockedStatus status;
  String? message;
  int? id;
  PresencesResponse? presences;

  PresenceState({required this.status, this.message, this.id, this.presences});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'id': id,
      'status': status.name,
      'presences': presences?.toJson()
    };
  }

  factory PresenceState.fromJson(Map<String, dynamic> json) {
    return PresenceState(
      presences: PresencesResponse.fromJson(json['presences']),
      message: json['message'],
      id: json['id'],
      status: ClockedStatus.values.firstWhere(
        (element) => element.name.toString() == json['status'],
      ),
    );
  }

  @override
  List<Object> get props => [status];
}
