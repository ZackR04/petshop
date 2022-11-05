import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_petshop/src/models/models.dart';
import 'package:my_petshop/src/services/services.dart';
import 'package:my_petshop/src/utilities/utilities.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserData>((event, emit) async {
      emit(UserIsLoading());
      String uid = await Commons().getUID();
      final result = await UserService().loadUserData(uid);
      emit(
        result.fold(
          (l) => UserIsFailed(message: l),
          (r) => UserIsSuccess(data: r),
        ),
      );
    });
    on<LogOutUser>((event, emit) async {
      UserService().logOutUser();
      await Commons().removeUID();
      emit(UserIsLogOut());
    });
  }
}
