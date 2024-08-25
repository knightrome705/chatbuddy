import 'package:chatbuddy/app/routes/screen_export.dart';
import 'package:chatbuddy/app/view/chats/chat.dart';
import 'package:chatbuddy/app/view/home/home.dart';
import 'package:chatbuddy/app/view/auth/login.dart';
import 'package:chatbuddy/app/view/auth/sigin.dart';
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
    
    
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChatScreen(
            receiverId: args['receiverId'],
            receiverName: args['receiverName'],
            receiverImage: args['receiverImage'],
             recieverStatus:args['receiverStatus'],
          ),
        );
  
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
