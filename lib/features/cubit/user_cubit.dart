import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:randomperson/helper/service_locator.dart';
import 'package:randomperson/models/user.dart';
import 'package:randomperson/services/iuserservice.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  late IUserService _userService;

  UserCubit() : super(UserInitial()) {
    _userService = serviceLocator.get<IUserService>();
    getRandomUser();
  }

  void getRandomUser() async {
    emit(UserLoading());
    try {
      var user = await _userService.getRandomUser();

      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
