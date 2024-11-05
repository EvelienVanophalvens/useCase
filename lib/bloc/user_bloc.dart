import 'package:demo/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository userRepository; 
  UserBloc({required this.userRepository}) : super(UserInitial()){
    on<LoginEvent>(login);
    on<LogoutEvent>(logout);
  }

  void login(LoginEvent event, Emitter<UserState> emit ) async {
    try{
      emit(LoginLoading());
      final response = await userRepository.login(event.user.username, event.user.password);
      if(response['statusCode'] == 200){
        emit(LoginSucces());
      }else{
        emit(LoginFailed("Password or Username is incorrect"));
      }
    }catch(e){
      emit(LoginFailed("Something went wrong"));
    }
  }

  void logout(LogoutEvent event, Emitter<UserState> emit) async{
    try{
      emit(LogoutLoading());
      final response = await userRepository.logout();
      if(response['statusCode'] == 200){
        emit(LogoutSucces());
      }else{
        emit(LoginFailed("Something went wrong"));
      }
    }catch(e){
      emit(LoginFailed("Something went wrong"));
    }
  }
}