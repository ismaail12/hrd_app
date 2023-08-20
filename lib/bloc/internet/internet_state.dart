part of 'internet_bloc.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}
class InternetLoading extends InternetState {}

class Connected extends InternetState {
  final String message;
  const Connected(this.message);

  @override
  List<Object> get props => [message];
}

class NotConnected extends InternetState {
  final String message;
  const NotConnected(this.message);

  @override
  List<Object> get props => [message];
}
