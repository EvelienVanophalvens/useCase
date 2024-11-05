import 'package:demo/bloc/user_bloc.dart';
import 'package:demo/bloc/user_event.dart';
import 'package:demo/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is LogoutSucces) {
            Navigator.of(context).pop();
          } else if (state is LogoutFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
    child:
      AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              context.read<UserBloc>().add(LogoutEvent());
            }, 
          icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}