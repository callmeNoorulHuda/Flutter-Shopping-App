import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_cart/ui/widgets/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Container(
          alignment: Alignment.center,
          height: 500,
          width: 500,
          child: Lottie.asset(
            "assets/lottie/Animation - 1751456987419.json",
            alignment: Alignment.center,
            fit: BoxFit.cover,

            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
      ),

      nextScreen: const LoginScreen(),
      splashTransition: SplashTransition.sizeTransition,
      duration: 3000,
      backgroundColor: Colors.white,
    );
  }
}
