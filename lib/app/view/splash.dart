import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20)
              ),
            )
            
          ],
        ),
      ),
    );
  }
}
