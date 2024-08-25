import 'package:chatbuddy/app/routes/screen_export.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/animation/splash.json', 
                
              ),
            ),
            const Text(
              "Welcome to chatBuddy",
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, loginScreenRoute);
              },
              icon: const Text(
                "Skip",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
