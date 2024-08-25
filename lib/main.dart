import 'package:chatbuddy/app/controller/auth/auth_provider.dart';
import 'package:chatbuddy/app/controller/auth/login_provider.dart';
import 'package:chatbuddy/app/controller/home/home_provider.dart';
import 'package:chatbuddy/app/routes/route_constants.dart';
import 'package:chatbuddy/app/routes/router.dart';
import 'package:chatbuddy/app/theme/app_theme.dart';
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
        // ChangeNotifierProvider(create: (_) => ChatPr 
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
      theme:AppTheme.lightTheme(context) ,
      initialRoute: splashScreenRoute,
      onGenerateRoute: generateRoute,
    );
  }
}
