import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> logout() async {
    try {
      await Auth().logout();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            color: Colors.white, icon: const Icon(Icons.logout, color: Colors.white), onPressed: () { logout(); },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(48),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Home Page", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
              ),
            ],
          ),
        ),
      )
    );
  }
}