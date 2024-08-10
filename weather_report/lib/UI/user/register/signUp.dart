import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_report/UI/admin/Home.dart';
import 'package:weather_report/UI/helper/Customsnackbar.dart';
import 'package:weather_report/UI/user/HomeUser.dart';
import 'package:weather_report/UI/widgets/customTextfield.dart';
import 'package:weather_report/provider/adminprovider/authenticate.dart';
import 'package:weather_report/provider/userprovider/UserProvider.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
    final namecntrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var provider = Provider.of<Userprovider>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange.shade900,
          Colors.orange.shade800,
          Colors.orange.shade400,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  hintText: "Email",
                                  hintStyle:
                                      TextStyle(color: Colors.orange.shade600),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                ),
                                CustomTextFormField(
                                  hintText: "Password",
                                  hintStyle:
                                      TextStyle(color: Colors.orange.shade600),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                ),
                                CustomTextFormField(
                                  hintText: "User name",
                                  hintStyle:
                                      TextStyle(color: Colors.orange.shade600),
                                  obscureText: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  controller: namecntrl,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                         
                          const SizedBox(height: 60),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                await provider.register(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: namecntrl.text.trim()
                                  
                                );
                                setState(() {
                                  loading = false;
                                });
                                if(provider.signUp==true)
                                {
                                  Customsnackbar.showSuccess(
                                    "success", context);
                                  Navigator.of(context).pop();
                                  
                                }
                                else{
                                  Customsnackbar.showError(provider.Error.toString(), context);
                                }
                                
                               
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.orange.shade800,
                              ),
                              child: Center(
                                child: loading == false
                                    ? const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
