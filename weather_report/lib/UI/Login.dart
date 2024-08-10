import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_report/UI/admin/Home.dart';
import 'package:weather_report/UI/helper/Customsnackbar.dart';
import 'package:weather_report/UI/splash.dart';
import 'package:weather_report/UI/user/HomeUser.dart';
import 'package:weather_report/UI/user/register/signUp.dart';
import 'package:weather_report/UI/widgets/customTextfield.dart';
import 'package:weather_report/provider/adminprovider/authenticate.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String selectedRole = 'User'; // Default role
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var provider = Provider.of<Auth>(context);
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
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
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
                              )
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                    child: CustomTextFormField(
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          color: Colors.orange.shade600),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter an email';
                                        }
                                        return null;
                                      },
                                      controller: email,
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  child: CustomTextFormField(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.orange.shade600),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a password';
                                      }
                                      return null;
                                    },
                                    controller: password,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                DropdownButton<String>(
                                  value: selectedRole,
                                  elevation: 16,
                                  style: TextStyle(
                                    color: Colors.orange.shade600,
                                    fontSize: 16,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.orange.shade600,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedRole = newValue!;
                                    });
                                    log("Selected Role: $selectedRole");
                                  },
                                  items: <String>['User', 'Admin']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.orange),
                        ),
                        const SizedBox(height: 60),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              await provider.Login(
                                email: email.text.trim(),
                                password: password.text.trim(),
                              );
                              setState(() {
                                loading = false;
                              });
                              if (provider.success == true &&
                                  selectedRole == "Admin") {
                                log("Login success as $selectedRole");
                                if (email.text.trim() == "Admin@gmail.com" ||
                                    email.text.trim() == "admin@gmail.com") {
                                  Customsnackbar.showSuccess(
                                      "login Sucess", context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SplashScreen(),
                                    ),
                                  );
                                } else {
                                  Customsnackbar.showError(
                                      "Your Email is not found in the admin section",
                                      context);
                                }
                              } else if (provider.success == true &&
                                  selectedRole == "User") {
                                    log("kkkkkkkkk");
                                if (email.text.trim()=="admin@gmail.com"||
                                    email.text.trim()=="Admin@gmail.com") {
                                  
                                  Customsnackbar.showError(
                                      "Not a valid mail", context);
                                } else {
                                  Customsnackbar.showSuccess(
                                      "login Sucess", context);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => SplashScreen(),
                                    ),
                                  );
                                }
                              } else {
                                Customsnackbar.showError(
                                    provider.Error.toString(), context);
                                log("Login failed");
                              }
                            } else {
                              log("Form is not valid");
                            }
                            // setState(() {
                            //   loading = true;
                            // });
                            // await provider.Login(
                            //   email: email.text.trim(),
                            //   password: password.text.trim(),
                            // );
                            // setState(() {
                            //   loading = false;
                            // });
                            // if (provider.success == true &&
                            //     selectedRole == "Admin") {
                            //   log("Login success as $selectedRole");
                            //   Customsnackbar.showSuccess(
                            //       "login Sucess", context);
                            //   Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //       builder: (context) => const Homeadmin(),
                            //     ),
                            //   );
                            // } else if (provider.success == true &&
                            //     selectedRole == "User") {
                            //   Customsnackbar.showSuccess(
                            //       "login Sucess", context);
                            //   Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //       builder: (context) => const Homeuser(),
                            //     ),
                            //   );
                            // } else {
                            //   Customsnackbar.showError(
                            //       provider.Error.toString(), context);
                            //   log("Login failed");
                            // }
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
                        SizedBox(
                          height: height * 0.15,
                        ),
                        selectedRole == "User"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "If you dont have an Account  ",
                                    style: TextStyle(fontSize: 16.5),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => Signupscreen(),
                                        ));
                                      },
                                      child: Text("click here",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.orange.shade800,
                                          )))
                                ],
                              )
                            : SizedBox()
                      ],
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
