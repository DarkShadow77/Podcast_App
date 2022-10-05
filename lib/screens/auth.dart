import 'package:flutter/material.dart';
import 'package:podcast/screens/login.dart';
import 'package:podcast/screens/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickedSignUp: toogle)
      : SignUpPage(onClickedSignIn: toogle);

  void toogle() => setState(() {
        isLogin = !isLogin;
      });
}
