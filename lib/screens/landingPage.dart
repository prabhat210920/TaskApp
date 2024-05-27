import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/screens/signupPage.dart';
import 'package:taskapp/widgets/button.dart';
import 'package:taskapp/screens/loginPage.dart';

class SignupPage extends StatelessWidget{
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('asset/image1.png', fit: BoxFit.cover),

            CustomButton(text: "Sign Up", color: Colors.blue, onPressed: (){
              Get.to(const SignUpPage());
            }),
            const SizedBox(height: 15,),

            CustomButton(text: "Login", color: Colors.blue, onPressed: (){
              Get.to(const LoginPage());
            }),

          ],
        ),
      ),
    );
  }
}