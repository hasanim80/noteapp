import 'package:flutter/material.dart';

class CustomTextFormShow extends StatelessWidget {
  final String? hint;
  final String? Function(String?) valid;
  final TextEditingController mycontroller;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? fontSize;


  const CustomTextFormShow({
    Key? key,
    this.maxLines,
    this.hint,
    required this.mycontroller,
    required this.valid,
    this.fontWeight,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style:  TextStyle(fontWeight: fontWeight , fontSize: fontSize),
        maxLines: maxLines,
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            hintText: hint,
            hintMaxLines: 20,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))
            ),
      ),
    );
  }
}
