import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:simple_firebase_login/screen/splashScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Menu {
  final IconData icon;
  final String title;

  Menu(this.icon, this.title);
}

class _HomeScreenState extends State<HomeScreen> {
  String _email = "";
  String _time = "";
  final menuList = [
    Menu(Icons.newspaper_rounded, "berita"),
    Menu(Icons.monetization_on_rounded, "gaji"),
    Menu(Icons.desktop_mac_rounded, "monitor"),
    Menu(Icons.track_changes, "nilai"),
  ];

  @override
  void initState() {
    _getEmail();
    _setTime();
    Timer.periodic(Duration(seconds: 1), (timer) => _setTime());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // langkah 1

      // appBar: AppBar(
      //   title: const Text(
      //     'halaman home',
      //   ),
      //   // leading: IconButton(
      //   //   onPressed: () {},
      //   //   icon: Icon(Icons.person),
      //   // ),
      // ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () => logout(),
      //     child: const Text('Sign Out'),
      //   ),
      // ),

      body: Stack(
        children: [
          Container(
            color: Colors.amber,
            height: 180,
            // agar appbarnya lebar penuh kiri dan kanan
            // ini simple
            width: double.infinity,
            // ini secara detail
            // width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              // mengatur jarak dengan status bar
              SizedBox(
                // height: MediaQuery.of(context).padding.top,
                height: MediaQuery.of(context).padding.top + 12,
              ),
              _buildNameWidget(),

              // card
              // const Card(
              //   child: Padding(
              //     padding: const EdgeInsets.all(24),
              //     child: Text(
              //       'fdasfdsa fdafda',
              //       style: TextStyle(fontSize: 24),
              //     ),
              //   ),
              // )

              // card custom
              __buildCardWidget(),
              GridView.count(
                // jmlh baris horizontal
                crossAxisCount: 4,
                shrinkWrap: true,
                // children: [
                //   _buildMenuWidget(Icons.newspaper_rounded, "berita"),
                //   _buildMenuWidget(Icons.monetization_on_rounded, "gaji"),
                //   _buildMenuWidget(Icons.desktop_mac_rounded, "monitor"),
                //   _buildMenuWidget(Icons.track_changes, "nilai"),
                // ],

                // perulangan dari liste menu
                children: menuList
                    .map((menu) => _buildMenuWidget(menu.icon, menu.title))
                    .toList(),
              ),
              // Text(
              //   'isi text 2',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 28,
              //   ),
              // ),

              Container(
                child: ElevatedButton(
                  onPressed: () => logout(),
                  child: Text('Sign Out'),
                ),
              )
              // body: Center(
              //   child: ElevatedButton(
              //     onPressed: () => logout(),
              //     child: const Text('Sign Out'),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  // reuseable widget
  Column _buildMenuWidget(
    IconData icon,
    String title,
  ) {
    return Column(
      children: [
        Icon(
          // Icons.newspaper_rounded,
          icon,
          size: 32,
          color: Colors.blue,
        ),
        const SizedBox(height: 10),
        Text(
          // "berita",
          title,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Container __buildCardWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // color: Colors.blue.withOpacity(opacity)
            color: Colors.black12,
            spreadRadius: 6,
            blurRadius: 4,
          ),
        ],
      ),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Column(
        children: [
          // Text(DateTime.now().toIso8601String()),
          // Text(_format()),
          Text(_format("EEE, dd MMM yyyy")),
          SizedBox(height: 12),
          Text(
            _time,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      // child: Text(
      //   'fdasfdsa fdafda',
      //   style: TextStyle(fontSize: 24),
      // ),
    );
  }

  String _format(String pattern) {
    // final format = DateFormat("EEE, dd MMM yyyy");
    final format = DateFormat(pattern);
    return format.format(DateTime.now());
  }

  _setTime() {
    setState(() {
      _time = _format("HH:mm:ss");
    });
  }

  // method yang berisi nama dibagian atas
  // Padding _buildNameWidget() {
  // utk lebih general dan aman pada saat ganti2 methodnya
  Widget _buildNameWidget() {
    return Padding(
      // padding: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(Icons.person),
            backgroundColor: Colors.white,
          ),
          SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: ,
            children: [
              Text(
                _email,
                // 'isi text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'instansi ppppppppppp',
                style: TextStyle(
                  color: Colors.white,
                  // fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  logout() async {
    // await ini utk menunggu apakah singout ini berhasil atau belum
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
      (route) => false,
    );
  }

  void _getEmail() {
    final auth = FirebaseAuth.instance.currentUser;
    _email = auth!.email!;
  }
}
