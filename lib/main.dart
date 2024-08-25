import 'package:chatbuddy/app/controller/auth/auth_provider.dart';
import 'package:chatbuddy/app/controller/auth/login_provider.dart';
import 'package:chatbuddy/app/controller/chats/chat_provider.dart';
import 'package:chatbuddy/app/controller/home/home_provider.dart';
import 'package:chatbuddy/app/routes/route_constants.dart';
import 'package:chatbuddy/app/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbuddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: splashScreenRoute,
      onGenerateRoute: generateRoute,
    );
  }
}
