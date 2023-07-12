import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:simple_firebase_login/screen/login_screen.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // fungsi yg dipanggil pertama kali ketika class ini muncul
  void initState() {
    // TODO: implement initState

    checkAuth();
    super.initState();
  }

  // memanggil firebaseauth
  checkAuth() async {
    final auth = FirebaseAuth.instance.currentUser;
    //jika auth null dia kehalaman login
    if (auth == null) {
      Future.delayed(const Duration(seconds: 3)).then(
        // (value) => Navigator.push(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        ),
      );
    } else {
      Future.delayed(const Duration(seconds: 3)).then(
        // ini akan mengarahkan ke halaman homescreen
        // (value) => Navigator.push(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        ),
      );
    }

    ///langkah 2
    // await Future.delayed(const Duration(seconds: 3)).then(
    //   (value) => Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const LoginScreen()),
    //   ),
    // );

    ///langkah 1
    // delay ini solusi dari errornya
    // await Future.delayed(Duration(seconds: 3));

    // memindahkan screen
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue,
          child: const Center(
            child: Text(
              'logo tengah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
