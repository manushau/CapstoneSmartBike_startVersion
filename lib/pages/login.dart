import 'package:flutter/material.dart';
import 'package:phone_app/components/input_text_field.dart';
import 'homePage.dart';
import 'package:phone_app/components/bottom_button.dart';
import 'package:phone_app/components/text_tap_button.dart';
import 'package:phone_app/utilities/constants.dart';
import 'package:phone_app/pages/signup.dart';
import '../components/login_signup_background.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(), // an entry point
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: CustomGradientContainerFull(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Redback Logo
                  Image(
                    image: AssetImage('lib/assets/redbacklogo.png'),
                    height: 150,
                  ),
                  // App Name
                  Text(
                    "Redback Smart Bike",
                    style: kRedbackTextMain,
                  ),
                  SizedBox(height: 70),
                  InputTextField(buttonText: 'email'),

                  SizedBox(height: 15),
                  InputTextField(buttonText: 'password'),
                  SizedBox(height: 70),
                  BottomButton(
                    onTap: () {
                      // login logic
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            title: '',
                          ),
                        ),
                      );
                    },
                    buttonText: 'Log In',
                  ),
                  SizedBox(height: 26),
                  TextTapButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    buttonTextStatic: 'Don\'t have an account?  ',
                    buttonTextActive: 'Sign up',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
