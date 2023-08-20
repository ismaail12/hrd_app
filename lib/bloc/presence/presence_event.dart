part of 'presence_bloc.dart';

abstract class PresenceEvent extends Equatable {
  const PresenceEvent();

  @override
  List<Object> get props => [];
}

class GetPresence extends PresenceEvent {}

class PresenceInitial extends PresenceEvent {}
