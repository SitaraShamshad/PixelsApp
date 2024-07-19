import 'package:flutter/material.dart';
import 'package:pixelsapp/splashscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pexels Wallpapers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: SplashScreen(),
    );
  }
}
