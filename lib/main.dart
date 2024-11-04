import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.grey,
      ),
      scaffoldBackgroundColor:  Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      )
     ),
     home: const  Login()
    );
  }
}
