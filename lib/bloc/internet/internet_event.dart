part of 'internet_bloc.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

class OnConnected extends InternetEvent {
  final String message;
  const OnConnected(this.message);

  @override
  List<Object> get props => [message];
}

class OnNotConnected extends InternetEvent {
  final String message;
  const OnNotConnected(this.message);

  @override
  List<Object> get props => [message];
}
