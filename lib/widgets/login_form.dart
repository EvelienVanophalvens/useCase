import 'package:demo/bloc/user_bloc.dart';
import 'package:demo/bloc/user_event.dart';
import 'package:demo/bloc/user_state.dart';
import 'package:demo/models/user.dart';
import 'package:demo/pages/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
   final UserModel userModel = UserModel(username: '', password: '');

  bool obscure = true;

  void _togglevisibility() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is LoginSucces) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Blog()),
            );
          } else if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child:  Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 32),
                        TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(width: 1)),
                            filled: true,
                            fillColor: Colors.grey.shade300.withOpacity(0.4),
                            hintText: "username",
                            hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => userModel.username = value ?? '',
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          obscureText: obscure,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide(width: 1)),
                            filled: true,
                            fillColor: Colors.grey.shade300.withOpacity(0.4),
                            hintText: "Password",
                            hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            suffixIcon: IconButton(
                              onPressed: _togglevisibility,
                              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => userModel.password = value ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
                                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context.read<UserBloc>().add(LoginEvent(user: userModel));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      minimumSize: const Size(double.infinity, 15),
                      backgroundColor: const Color.fromARGB(255, 87, 145, 180),
                    ),
                    child: const Text("Login"),
                  )
              ]
            ),
          ),
        ),
      );
  }
}