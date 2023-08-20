import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  late StreamSubscription internetSub;

  InternetBloc() : super(InternetInitial()) {
    on<OnConnected>((OnConnected event, Emitter<InternetState> emit) {
      emit(Connected(event.message));
    });

    on<OnNotConnected>((OnNotConnected event, Emitter<InternetState> emit) {
      emit(NotConnected(event.message));
    });

    internetSub = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile) {
          final resultCheck = await InternetConnectionChecker().hasConnection;
          if (!resultCheck) {
            add(const OnNotConnected('Internet not connected'));
            return;
          }
          add(const OnConnected('Internet Connected'));
        } else {
          add(const OnNotConnected('Internet not connected'));
        }
      },
    );
  }

  @override
  Future<void> close() {
    internetSub.cancel();
    return super.close();
  }
}
