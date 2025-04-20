part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
  
  @override
  List<Object> get props => [user];


}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object> get props => [message];
}
