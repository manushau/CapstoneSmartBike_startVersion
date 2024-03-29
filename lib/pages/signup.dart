import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phone_app/utilities/constants.dart';
import 'package:phone_app/pages/login.dart';
import 'package:phone_app/components/text_tap_button.dart';
import '../components/bottom_button.dart';
import '../components/input_text_field.dart';
import '../components/login_signup_background.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Function to make a POST request to your API
  Future<void> signUp() async {
    final apiUrl = 'http://192.168.1.31:8000/users/';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text
      },
    );
    print('username: ${usernameController.text}');
    if (response.statusCode == 201) {
      // Success! You can handle the response here if needed.
      print('Sign-up successful!');
    } else {
      // Error handling here, you can show an error message to the user.
      print('Sign-up failed. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: CustomGradientContainerFull(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.0),
                const Image(
                  image: AssetImage('lib/assets/redbacklogo.png'),
                  height: 110,
                ),
                // SizedBox(height: 16),
                // TextTapButton(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => LoginPage(),
                //       ),
                //     );
                //   },
                //   buttonTextActive: 'Log In',
                // ),
                SizedBox(height: 22),
                Text(
                  'Sign Up',
                  style: kRedbackTextMain,
                ),
                SizedBox(height: 32),
                InputTextField(buttonText: 'username', fieldController: usernameController,),
                SizedBox(height: 15),
                InputTextField(buttonText: 'email', fieldController: emailController,),
                SizedBox(height: 15),
                InputTextField(buttonText: 'password', fieldController: passwordController,),
                SizedBox(height: 60),
                BottomButton(
                    onTap: () {
                      signUp();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    buttonText: 'Sign Up'),
                SizedBox(height: 32),
                TextTapButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  buttonTextStatic: 'Already have an account?  ',
                  buttonTextActive: 'Log In',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
