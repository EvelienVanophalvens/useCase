import 'package:demo/repositories/user_repository.dart';

sealed class AuthenticationState {}
sealed class LogoutState{}

class LogginSucces extends AuthenticationState {}
class LogginFailed extends AuthenticationState {}
class LogoutSucces extends LogoutState {}
class LogoutFailed extends LogoutState {}

class UserViewModel {
  final UserRepository userRepository;

  UserViewModel(this.userRepository);

  
  
  Future<AuthenticationState> login(String username, String password) async {
    final response = await userRepository.login(username, password);
    final int statusCode = response['statusCode'];


      if (statusCode == 200) {
        return LogginSucces();
      } else {
        return LogginFailed();
      }
  }

  Future<LogoutState>logout() async{
      final response = await userRepository.logout();
      final int statusCode = response['statusCode'];


      if(statusCode == 200){
        return LogoutSucces();
      }else{
        return LogoutFailed();
      }
  }
}