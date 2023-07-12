// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:simple_firebase_login/screen/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();
  final _passwordConfirmInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // shadow
        elevation: 0,

        // icon back
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // utk penggunaan scroll, mirip overview
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              // Padding(
              //   padding: const EdgeInsets.only(top: 60),
              // ),

              const Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              ///langkah 1
              // const TextField(
              //   decoration: InputDecoration(
              //     // utk mengilangkan border pada text field
              //     border: InputBorder.none,
              //   ),
              // ),

              ///langkah 2
              Container(
                margin: const EdgeInsets.only(top: 32),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      // menentukan letak shadow
                      // offset: Offset(),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _emailInput,
                  decoration: const InputDecoration(
                    // utk mengilangkan border pada text field
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      // menentukan letak shadow
                      // offset: Offset(),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _passwordInput,
                  decoration: const InputDecoration(
                    // utk mengilangkan border pada text field
                    border: InputBorder.none,
                    hintText: 'Password',
                  ),
                  // utk menyembunyikan input text
                  obscureText: true,
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      // menentukan letak shadow
                      // offset: Offset(),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _passwordConfirmInput,
                  decoration: const InputDecoration(
                    // utk mengilangkan border pada text field
                    border: InputBorder.none,
                    hintText: 'Confirm Password',
                  ),
                  // utk menyembunyikan input text
                  obscureText: true,
                ),
              ),

              // TextField(),

              const SizedBox(height: 24),

              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('Sign in'),
              // ),

              // kita bisa menggunakan Container atau SizedBox
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => register(),
                  child: Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  register() async {
    if (_passwordInput.text == _passwordConfirmInput.text) {
      try {
        // final credential =
        //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailInput.text,
          password: _passwordInput.text,
        );
        Future.delayed(const Duration(seconds: 3)).then(
          // (value) => Navigator.push(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
        );
        // print(credential.user!.email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    } else {
      print('password & confirmation password not match');
    }
  }
}
