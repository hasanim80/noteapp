import 'package:flutter/material.dart';

class CustomTextFormSign extends StatelessWidget {
  final TextInputType? keyboardType;
  final bool obscureText;
  final String hint;
  final String? Function(String?) valid;
  final TextEditingController mycontroller;
  final IconButton? icon;
  final IconButton icon2;
  final int? maxLines;


  const CustomTextFormSign(
      {Key? key,
        required this.obscureText,
      this.keyboardType,
        this.maxLines,
      required this.hint,
      required this.mycontroller,
      required this.valid,
       this.icon,
      required this.icon2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(maxLines: maxLines,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            prefixIcon: icon,
            suffixIcon: icon2,
            hintText: hint,
            hintMaxLines: 20,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
