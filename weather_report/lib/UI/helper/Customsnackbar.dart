import 'package:flutter/material.dart';

class Customsnackbar
{
  static void showSuccess(String msg,BuildContext context)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: Colors.green,));
  }
  static void showError(String msg,BuildContext context)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: Colors.red,));
  }
}