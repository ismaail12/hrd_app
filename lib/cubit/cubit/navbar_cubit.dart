
import 'package:bloc/bloc.dart';

class NavbarCubit extends Cubit<int> {
  NavbarCubit() : super(0);
  
  void setIndex(int index) => emit(index);
}
