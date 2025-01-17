import 'package:flutter/material.dart';



class customButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final double fontSize;
  const customButton({Key? key, required this.title, required this.onTap, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: Colors.black,
      onPressed: onTap,
      height: 55,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
