import 'package:flutter/material.dart';
import 'package:podcast/LoginPage/body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onClickedSignUp}) : super(key: key);

  final VoidCallback onClickedSignUp;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Body(
          onClickedSignUp: widget.onClickedSignUp,
        ),
      ),
    );
  }
}
