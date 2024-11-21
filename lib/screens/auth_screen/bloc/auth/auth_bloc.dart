import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../../api/user_service.dart';
import '../../modal/user_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      // Call the loginUser method to fetch user data
      final userData = await UserService.loginUser(email: event.email, password: event.password);

      // Handle null user data (invalid credentials)
      if (userData == null) {
        emit(const AuthenticationFailure(error: "Invalid email or password"));
        return;
      }

      // Log the fetched user data for debugging
      log("Fetched user data: $userData");

      // Map user data to UserModel
      final user = UserModel(
        id: userData["username"] ?? "Unknown User", // Default if username is null
        email: userData["email"] ?? "Unknown Email", // Default if email is null
      );

      // Log the mapped UserModel
      log("Mapped user: $user");

      // Emit success state with the UserModel
      emit(AuthenticationSuccess(user: user));
    } catch (error) {
      // Emit failure state with error message
      emit(AuthenticationFailure(error: "Login failed: ${error.toString()}"));
    }
  }
}
