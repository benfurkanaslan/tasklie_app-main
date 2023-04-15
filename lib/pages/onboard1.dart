import 'package:flutter/material.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //create splash screen

          Padding(
        padding: const EdgeInsets.all(120.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset('assets/tasklie.png').image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
