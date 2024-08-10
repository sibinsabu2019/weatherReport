import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_report/UI/Login.dart';
import 'package:weather_report/UI/splash.dart';
import 'package:weather_report/firebase_options.dart';
import 'package:weather_report/provider/adminprovider/authenticate.dart';
import 'package:weather_report/provider/userprovider/UserProvider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Auth(),
      ),
      ChangeNotifierProvider(create: (context)=> Userprovider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SplashScreen(),
    );
  }
}
