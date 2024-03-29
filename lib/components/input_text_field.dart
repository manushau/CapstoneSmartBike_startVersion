import 'package:flutter/material.dart';
import 'package:phone_app/utilities/constants.dart';

class InputTextField extends StatelessWidget {
  // custom constructor
  InputTextField({required this.buttonText, this.fieldController, this.height});

  // use VoidCallback instead of Function

  final String buttonText;
  final TextEditingController? fieldController; // optional
  final double? height; // optional

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: kLoginRegisterBtnColour, // Default border color
          width: 2.0, // Default border width
        ),
        color:
            kFillInText.withOpacity(0.1), // Set the fill color and opacity here
        borderRadius:
            BorderRadius.circular(10.0), // Set border radius if needed
      ),
      child: TextFormField(
        textAlign: TextAlign.left,
        controller: fieldController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: buttonText,
          labelStyle: TextStyle(color: kFillInText),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none, // No underline
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 30, 0, 0),
        ),

        //style: TextStyle(fontSize: height != null ? height! * 0.5 : 22.0),
      ),
    );
  }
}
