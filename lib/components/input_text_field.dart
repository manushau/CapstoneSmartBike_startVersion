import 'package:flutter/material.dart';
import 'package:phone_app/utilities/constants.dart';

class InputTextField extends StatefulWidget {
  // Custom constructor
  InputTextField({
    required this.buttonText,
    this.fieldController,
    this.height,
    this.enableToggle = false,
    this.validator,
    this.helperText,
  }) : obscureText = enableToggle ? true : false;

  final String buttonText;
  final TextEditingController? fieldController;
  final double? height;
  final bool enableToggle;
  final FormFieldValidator<String>? validator;
  final String? helperText;

  bool obscureText;

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  void toggleObscured() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded( // Wrap with Expanded to fill available space
            child: TextFormField(
              textAlign: TextAlign.left,
              controller: widget.fieldController,
              obscureText: widget.obscureText,
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: widget.buttonText,
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                suffixIcon: widget.enableToggle ? _buildSuffixIcon() : null,
              ),
            ),
          ),
          if (widget.helperText != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.helperText!,
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return GestureDetector(
      onTap: toggleObscured,
      child: Icon(
        widget.obscureText ? Icons.visibility : Icons.visibility_off,
        size: 24,
        color: Colors.black,
      ),
    );
  }
}



/* working version

import 'package:flutter/material.dart';
import 'package:phone_app/utilities/constants.dart';

class InputTextField extends StatefulWidget {
  // custom constructor
  InputTextField({
    required this.buttonText,
    this.fieldController,
    this.height,
    this.enableToggle = false, // Add a new property to enable/disable toggle
  }) : obscureText = enableToggle
            ? true
            : false; // Initialize obscureText based on enableToggle

  final String buttonText;
  final TextEditingController? fieldController;
  final double? height;
  bool obscureText;
  final bool enableToggle; // New property to indicate toggle enablement

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  void toggleObscured() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: kLoginRegisterBtnColour,
          width: 2.0,
        ),
        color: kFillInText.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        textAlign: TextAlign.left,
        controller: widget.fieldController,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.buttonText,
          labelStyle: TextStyle(color: kFillInText),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 30, 0, 0),
          suffixIcon: widget.enableToggle
              ? _buildSuffixIcon()
              : null, // Conditionally show suffix icon
        ),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return GestureDetector(
      onTap: toggleObscured,
      child: Icon(
        widget.obscureText
            ? Icons.visibility_rounded
            : Icons.visibility_off_rounded,
        size: 24,
        color: kLoginRegisterBtnColour,
      ),
    );
  }
}

 */
