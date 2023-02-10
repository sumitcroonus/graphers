import 'dart:async';

import 'package:flutter/material.dart';

import 'package:graphers/screens/home.dart';

import 'package:graphers/screens/otp_verification.dart';

import 'package:shared_preferences/shared_preferences.dart';

String? finalNo;

class SplashScren extends StatefulWidget {
  const SplashScren({super.key});

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        print(finalNo);
        if (finalNo == null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const OtpVerification(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      });
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedPhoneNo = sharedPreferences.getString('phoneNo');
    setState(() {
      finalNo = obtainedPhoneNo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(199, 62, 29, 0.7),
        child: const Center(
            child: Text(
          "Graphers",
          style: TextStyle(fontSize: 40, fontFamily: 'Unbounded'),
        )),
      ),
    );
  }
}
