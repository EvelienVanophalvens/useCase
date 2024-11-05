abstract class UserState {}

class UserInitial extends UserState{}

class LoginLoading extends UserState{}
class LoginSucces extends UserState{}
class LoginFailed extends UserState{
  final String errorMessage;
  
  LoginFailed(this.errorMessage);
}

class LogoutLoading extends UserState{}
class LogoutSucces extends UserState{}
class LogoutFailed extends UserState{
    final String errorMessage;
  
  LogoutFailed(this.errorMessage);
}