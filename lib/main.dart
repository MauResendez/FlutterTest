import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/auth.dart';
import 'package:test/pages/home.dart';
import 'package:test/pages/landing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Home");
            return const Home();
          } else {
            print("Landing");
            return const Landing();
          }
        },
      ),
    );
  }
}