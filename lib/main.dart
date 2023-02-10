import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:graphers/screens/dummyscreen.dart';
import 'package:graphers/screens/home.dart';
import 'package:graphers/screens/photographer_registeration_scrren.dart';
import 'package:graphers/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Graphers',
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}
