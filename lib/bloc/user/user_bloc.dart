import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hrd_app/data/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository = UserRepository();

  UserBloc() : super(UserState(status: UserStatus.initial)) {
    on<UserChangePass>(_onUserChangePass);
  }

  Future<void> _onUserChangePass(
      UserChangePass event, Emitter<UserState> emit) async {
    final state = this.state;
    emit(UserState(status: UserStatus.loading));
    final response = await userRepository.changePass(
        current: event.oldPassword,
        newpass: event.newPassword,
        confirm: event.confirmPassword);
    response.fold((l) {
      print('kesini');
    }, (r) {
      if (r.statusCode == 200) {
        emit(UserState(
            status: UserStatus.success, message: 'Password berhasil diubah'));
        emit(state);
      } else {
        emit(UserState(
            status: UserStatus.error, message: 'Password tidak sama'));
        emit(state);
      }
    });
  }
}
