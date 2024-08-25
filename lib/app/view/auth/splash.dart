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
            // Replace the image container with Lottie animation
            Container(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/animation/splash.json', // Path to your Lottie animation file
                // fit: BoxFit.cover,
              ),
            ),
            const Text(
              "Welcome to the chat world",
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
