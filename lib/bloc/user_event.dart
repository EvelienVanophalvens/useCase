import 'package:demo/models/user.dart';

abstract class UserEvent {}

class LoginEvent extends UserEvent {
    final UserModel user;

    LoginEvent({required this.user});
}

class LogoutEvent extends UserEvent{}