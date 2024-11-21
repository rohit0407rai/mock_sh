import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List get props => [];
}

class RegistrationEvent extends RegisterEvent {
  final String username;
  final String email;
  final String password;

  const RegistrationEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List get props => [username, email, password];
}
