import 'package:demo/bloc/user_bloc.dart';
import 'package:demo/widgets/loginForm.dart';
import 'package:flutter/material.dart';
import 'package:demo/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => UserBloc(userRepository: userRepository),
        child: const LoginForm(),
      ),
    );
  }
}
