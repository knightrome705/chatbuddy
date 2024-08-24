import 'package:chatbuddy/app/routes/screen_export.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SizedBox(
            //   height: 150,
            // ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image:const DecorationImage(
                  image: AssetImage('assets/images/logo.jpg')
                ),
                borderRadius: BorderRadius.circular(100)
              ),
            ),
           const Text("Welcome to the chat world",style: TextStyle(fontSize: 20),),
           

            IconButton(onPressed: (){
              Navigator.pushReplacementNamed(context,loginScreenRoute);
            }, icon:const Text("Skip",style: TextStyle(color: Colors.blue),))
          ],
        ),
      ),
    );
  }
}
