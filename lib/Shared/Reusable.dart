import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart' as html_parser;

bool isValidEmail(String email) {
  String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
  RegExp regExp = RegExp(emailPattern);
  return regExp.hasMatch(email);
}

bool isPhoneNumber(String contact) {
  final phoneRegex = RegExp(r"^[0-9]{10,}$");
  return phoneRegex.hasMatch(contact);
}

bool isEmail(String contact) {
  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  return emailRegex.hasMatch(contact);
}

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);  
  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
  return formattedDate;
}

String removeHtmlTags(String htmlString) {
  var document = html_parser.parse(htmlString);
  return document.body?.text ?? ''; 
}


class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
         counterText: '',
         labelStyle: TextStyle(color: Colors.grey),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey, 
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 157, 15, 5), 
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 157, 15, 5), 
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: maxLines ?? 1, 
    );
  }
}

 calculateDaysDifference(DateTime startDate) {
    DateTime today = DateTime.now();
  DateTime someFutureDate = startDate;

  int daysDifference = someFutureDate.difference(today).inDays;

  return daysDifference;
}

String capitalizeEachWord(String text) {
  return text.split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}