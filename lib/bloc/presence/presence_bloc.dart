import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hrd_app/data/response/presence_response.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hrd_app/bloc/internet/internet_bloc.dart';

import 'package:hrd_app/data/repository/presence_repository.dart';
import 'package:hrd_app/utils/internet.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'presence_event.dart';
part 'presence_state.dart';

class PresenceBloc extends Bloc<PresenceEvent, PresenceState> {
  PresenceRepository presenceRepository = PresenceRepository();
  final InternetBloc internetBloc;
  String? token;
  late final StreamSubscription internetSubscription;
  bool internetConnection = false;

  PresenceBloc({required this.internetBloc})
      : super(PresenceState(status: ClockedStatus.initial)) {
    on<GetPresence>(_onGetPresence);

    checkInternetConnection();
    getToken();
    internetSubscription =
        internetBloc.stream.listen((InternetState internetState) {
      internetState is Connected
          ? internetConnection = true
          : internetConnection = false;
    });
  }

  Future<void> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
  }

  Future<void> checkInternetConnection() async {
    internetConnection = await getInternetConnection();
  }

  void _onGetPresence(GetPresence event, Emitter<PresenceState> emit) async {
    emit(PresenceState(status: ClockedStatus.loading));
    final response = await presenceRepository.todayPresence();
    response.fold((l) => null, (r) {
      emit(PresenceState(status: ClockedStatus.success, presences: r));
    });
  }

  // @override
  // PresenceState? fromJson(Map<String, dynamic> json) {
  //   return PresenceState.fromJson(json);
  // }

  // @override
  // Map<String, dynamic>? toJson(PresenceState state) {
  //   return state.toJson();
  // }
}
