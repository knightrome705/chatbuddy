import 'package:chatbuddy/app/routes/screen_export.dart';
import 'package:chatbuddy/app/view/chat.dart';
import 'package:chatbuddy/app/view/home.dart';
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
      
    case homeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
      
    case chatScreenRoute:
      // Check if arguments are provided and cast them safely
      if (settings.arguments != null ) {
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChatScreen(
            receiverId: args['receiverId'],
            receiverName: args['receiverName'],
            receiverImage: args['receiverImage'],
          ),
        );
      } else {
        // Handle the case when arguments are missing
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Invalid or missing arguments for ChatScreen"),
            ),
          ),
        );
      }
      
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text("Wrong pathway"),
          ),
        ),
      );
  }
}
