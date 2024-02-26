import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdla/screens/auth/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        theme: ThemeData(
            fontFamily: "Poppins",
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue),
        home: const Login());
  }
}
