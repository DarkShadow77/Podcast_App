import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:podcast/screens/home.dart';
import 'package:podcast/utils/colors.dart';
import 'package:podcast/widgets/backgound.dart';

import 'auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/impulse logo.png')),
              ),
            ),
            const Text(
              "Persian Podcast Portal",
              style: TextStyle(
                color: Color(0xff44465a),
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.backgroundColor,
        nextScreen: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong !'),
              );
            } else if (snapshot.hasData) {
              return HomePage();
            } else {
              return AuthPage();
            }
          },
        ),
        splashIconSize: 300,
        duration: 4000,
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
