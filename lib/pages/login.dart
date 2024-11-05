import 'package:demo/models/user.dart';
import 'package:demo/pages/blog.dart';
import 'package:flutter/material.dart';
import 'package:demo/viewModels/user_view_model.dart';
import 'package:demo/repositories/user_repository.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  UserRepository userRepository = UserRepository();
  late  final loginViewModel = UserViewModel(userRepository);
  final UserModel userModel = UserModel(username: '', password: '');

  bool obscure = true;

  void _togglevisibility(){
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
          Center(
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
                          const Text("Login", 
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          const SizedBox( height: 32,),
                          TextFormField(
                            decoration:    InputDecoration(
                              border:  const OutlineInputBorder(borderSide: BorderSide(width: 1)),
                              filled: true,
                              fillColor: Colors.grey.shade300.withOpacity(0.4),
                              hintText: "username",
                              hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty){
                                return 'please enter a username';
                              }else{
                                return null;
                              }
                            },
                            onSaved: (value) => userModel.username = value ?? ''
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            obscureText: obscure,
                            decoration: InputDecoration(
                              border:  const OutlineInputBorder(borderSide: BorderSide(width: 1)),
                              filled: true,
                              fillColor: Colors.grey.shade300.withOpacity(0.4),
                              hintText: "Password",
                              hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              suffixIcon: IconButton(onPressed: (){
                                _togglevisibility();
                              }, icon: Icon(obscure? Icons.visibility_off : Icons.visibility))
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty){
                                return 'please enter a username';
                              }else{
                                return null;
                              }
                            },
                            onSaved: (value) => userModel.password = value ?? ''
                          )
                        ],
                      )
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        final state = await  loginViewModel.login(userModel.username, userModel.password);
                        switch(state){
                          case LogginSucces():
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Blog())
                          );
                          case LogginFailed():
                           ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Username or Password is incorrect'),
                                backgroundColor: Colors.red,
                              ),
                            );
                        }
                      }
                    }, 
                    style: ElevatedButton.styleFrom( 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30 ),
                      minimumSize: const Size(double.infinity, 15),
                      backgroundColor: const Color.fromARGB(255, 87, 145, 180)
                    ),
                    child: const Text("Login"),
                  )
                ],
              ),
            )
      )
    );
  }
}