import 'package:chatbuddy/app/routes/screen_export.dart';
import 'package:chatbuddy/app/view/login.dart';
import 'package:chatbuddy/app/view/sigin.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );

    case loginScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case siginScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text("wrong pathway"),
          ),
        ),
      );
  }
}
