import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_statemanagement/domain/auth/login_request.dart';
import 'package:flutter_cubit_statemanagement/domain/auth/login_response.dart';
import 'package:flutter_cubit_statemanagement/infrastructure/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepository _authRepository = AuthRepository();

  void signInUser(LoginRequest loginRequest) async {
    emit(AuthLoading());
    try {
      final _data = await _authRepository.signInUserWithEmailAndPassword(
          loginRequest: loginRequest);
      _data.fold(
        (l) => emit(AuthError(l)),
        (r) => emit(AuthLoginSucces(r)),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
