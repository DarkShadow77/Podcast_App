import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:podcast/utils/colors.dart';
import 'package:podcast/utils/databasemethods.dart';
import 'package:podcast/widgets/background.dart';

import '../main.dart';
import '../utils/utils.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.onClickedSignIn}) : super(key: key);

  final VoidCallback onClickedSignIn;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ScrollController _scrollController;

  bool _isScrolled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Map<String, dynamic> userInfoMap = {
        "email": emailController.text.trim(),
        "username": userController.text.trim(),
      };
      DatabaseMethods()
          .addUserInfoDB(FirebaseAuth.instance.currentUser!.uid, userInfoMap);
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 50.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 130,
                      ),
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/impulse logo.png')),
                        ),
                      ),
                      Center(
                        child: const Text(
                          "Persian Podcast Portal",
                          style: TextStyle(
                            color: Color(0xff44465a),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              controller: userController,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "User Name",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff9394ad),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.containerone,
                                      width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff66687a), width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  gapPadding: 8,
                                ),
                                hintText: "Enter Your User Name",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff9394ad),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xff9394ad),
                                  size: 22,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (user) =>
                                  user != null && user.length < 4
                                      ? 'Enter min. 3 character'
                                      : null,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              controller: emailController,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff9394ad),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.containerone,
                                      width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff66687a), width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  gapPadding: 8,
                                ),
                                hintText: "Enter Your Email",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff9394ad),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xff9394ad),
                                  size: 22,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff9394ad),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.containerone,
                                      width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff66687a), width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  gapPadding: 8,
                                ),
                                hintText: "Enter Your Password",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff9394ad),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Color(0xff9394ad),
                                  size: 22,
                                ),
                                suffixIcon: Icon(
                                  Icons.visibility_outlined,
                                  color: Color(0xff9394ad),
                                  size: 22,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? 'Enter min. 6 characters'
                                      : null,
                              onChanged: (text) => setState(() {
                                password = text;
                              }),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: confirmpasswordController,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff9394ad),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.containerone,
                                      width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xff66687a), width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  gapPadding: 8,
                                ),
                                hintText: "Confirm Your Password",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff9394ad),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Color(0xff9394ad),
                                  size: 22,
                                ),
                                suffixIcon: Icon(
                                  Icons.visibility_outlined,
                                  color: Color(0xff9394ad),
                                  size: 22,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value != password
                                      ? 'Password not Matched'
                                      : null,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      GestureDetector(
                        onTap: signUp,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.containerone.withOpacity(0.80),
                                AppColors.containertwo,
                                AppColors.containerthree.withOpacity(0.90),
                              ],
                              stops: [
                                0.03,
                                0.4,
                                0.6,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff9394ad),
                            ),
                            text: "Already have an Account?  ",
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: AppColors.containerthree,
                                ),
                                text: "Log In",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignIn,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
