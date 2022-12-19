import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool visible = false;
  bool error = false;

  Future<void> register() async {
    try {
      await Auth().register(email: _emailController.text, password: _passwordController.text).then((value) => {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
      });
    } on FirebaseException catch (e) {
      setState(() {
        error = true;
      });
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Register", style: GoogleFonts.ubuntu(textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      key: const Key('email'),
                      controller: _emailController,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      keyboardAppearance: Brightness.light,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email, size: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      key: const Key('password'),
                      controller: _passwordController,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      keyboardAppearance: Brightness.light,
                      obscureText: visible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock, size: 25),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              visible = !visible;
                            });
                            print(visible);
                          },
                          child: Icon(
                            visible 
                            ? Icons.visibility 
                            : Icons.visibility_off, 
                            size: 25
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  onPressed: () { register(); },
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}