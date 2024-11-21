import 'package:equatable/equatable.dart';
import '../../modal/user_model.dart';


abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

// Initial state before any action
class AuthenticationInitial extends AuthenticationState {}

// State while logging in
class AuthenticationLoading extends AuthenticationState {}

// State when login is successful
class AuthenticationSuccess extends AuthenticationState {
  final UserModel user;

  const AuthenticationSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

// State when login fails
class AuthenticationFailure extends AuthenticationState {
  final String error;

  const AuthenticationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
