import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../api/user_service.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegistrationEvent>(_onRegistrationEvent);
  }

  Future<void> _onRegistrationEvent(
      RegistrationEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    try {
      // Call the UserService to register the user
      final success = await UserService.registerUser(
        username: event.username,
        email: event.email,
        password: event.password,
      );

      if (success) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(error: "Failed to register user."));
      }
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }
}
