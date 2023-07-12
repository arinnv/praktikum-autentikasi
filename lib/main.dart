import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_firebase_login/screen/splashScreen.dart';

import 'utils/app_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // karena ada await tambahkan async di bagian main
  await Firebase.initializeApp(
    name: AppConstant.firebaseName,
    options: const FirebaseOptions(
      apiKey: AppConstant.firebaseApiKey,
      appId: AppConstant.firebaseAppId,
      messagingSenderId: AppConstant.messagingSenderId,
      projectId: AppConstant.projectId,
    ),

    // options: const FirebaseOptions(
    //   apiKey: 'AIzaSyDtzxL2KCXZ4EqgAG1UZVVb-pm13RtInNg',
    //   appId: '1:195499672167:android:9919ae72627cc7ac0f8ac2',
    //   messagingSenderId: '195499672167',
    //   projectId: 'latihan-login-69b26',
    // ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'firebase login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),

      // mengammbil fungsi didalam splashScreen.dart
      home: const SplashScreen(),
      // Scaffold(
      //   appBar: AppBar(
      //     title: Center(
      //       child: Text('ini judul'),
      //     ),
      //   ),
      // ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
