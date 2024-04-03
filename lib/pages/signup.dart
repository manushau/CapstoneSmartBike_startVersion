import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phone_app/components/see_password_toggle_icon.dart';
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

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    String pattern = r'^(?=.*?[!@#$%^&*(),.?":{}|<>])';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    if (value.length < 5) {
      return 'Username must be at least 10 characters long';
    }
    return null;
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showPasswordRequirementsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Requirements'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Minimum 8 characters'),
              Text('At least 1 uppercase letter'),
              Text('At least 1 symbol'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      final apiUrl = 'http://192.168.1.31:8000/signup/';
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'user': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text
        },
      );

      if (response.statusCode == 302) {
        print('Sign-up successful!');
      } else {
        print('Sign-up failed. Status code: ${response.statusCode}');
      }
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0),
                  Center(
                    child: Image(
                      image: AssetImage('lib/assets/redbacklogo.png'),
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Sign Up',
                    style: kRedbackTextMain,
                  ),
                  SizedBox(height: 32),
                  InputTextField(
                    buttonText: 'username',
                    fieldController: usernameController,
                    validator: validateUsername,
                  ),
                  SizedBox(height: 15),
                  InputTextField(
                    buttonText: 'email',
                    fieldController: emailController,
                    validator: validateEmail,
                  ),
                  SizedBox(height: 15),
                  InputTextField(
                    buttonText: 'password',
                    fieldController: passwordController,
                    enableToggle: true,
                    validator: validatePassword,
                  ),
                  SizedBox(height: 15),
                  InputTextField(
                    buttonText: 'confirm password',
                    fieldController: confirmPasswordController,
                    enableToggle: true,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextButton(
                    onPressed: _showPasswordRequirementsDialog,
                    child: Text(
                      'Password Requirements',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BottomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              signUp();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            } else {
                              _showErrorSnackbar('Please correct the errors');
                            }
                          },
                          buttonText: 'Sign Up',
                        ),
                      ),
                      SizedBox(width: 10), // Add some spacing
                      Expanded(
                        child: BottomButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          buttonText: 'Log In',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?  ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextTapButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        buttonTextActive: 'Click',
                      ),
                    ],
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
