import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../services/auth_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService = AuthService();

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final success = await _authService.login(event.username, event.password);
        if (success) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure('Invalid username or password'));
        }
      } catch (e) {
        emit(LoginFailure('Something went wrong: ${e.toString()}'));
      }
    });
  }
}
