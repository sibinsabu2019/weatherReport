import 'package:flutter/material.dart';

class bottomnav extends StatelessWidget {
  IconData? icon;
   bottomnav({
    super.key,required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Icon(icon,size: 35,color: Colors.blue[700],);
  }
}