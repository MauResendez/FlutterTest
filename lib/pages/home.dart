import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  bool visible = false;
  bool error = false;
  Map<String, dynamic>? user;

  Future<void> logout() async {
    try {
      await Auth().logout();
      Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> updateData(String name, String username, String birthday) async {
    try {
      final user = FirebaseFirestore.instance.collection("Users").doc(Auth().currentUser?.uid);

      await user.set({ "name": name, "username": username, "birthday": birthday });
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
        padding: const EdgeInsets.all(32),
        child: Center(
          child: SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('Users').doc(Auth().currentUser!.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                Map<String, dynamic>? data = snapshot.data?.data();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("Home", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text("Name: ${data?['name']}", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text("Username: ${data?['username']}", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text("Birthday: ${data?['birthday']}", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              key: const Key('name'),
                              controller: _nameController,
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              keyboardAppearance: Brightness.light,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              key: const Key('username'),
                              controller: _usernameController,
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              keyboardAppearance: Brightness.light,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Username',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              key: const Key('birthday'),
                              controller: _birthdayController,
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              keyboardAppearance: Brightness.light,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Birthday',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(48),
                                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
                              ),
                              onPressed: () {
                                updateData(_nameController.text, _usernameController.text, _birthdayController.text);
                              }, 
                              child: const Text("Update")
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      )
    );
  }
}