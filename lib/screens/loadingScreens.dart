
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class loadingScreen extends StatelessWidget{
  const loadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'asset/spinner.json',
                fit: BoxFit.cover,
                reverse: false,
                repeat: true,
                width: 150, // Adjust the size of the animation as needed
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}