import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphers/screens/otp_verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        const SizedBox(
          height: 400,
        ),
        MaterialButton(
          onPressed: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove('phoneNo');
            Get.to(() => const OtpVerification());
          },
          color: const Color.fromRGBO(199, 62, 29, 0.6),
          child: const Text('Log out'),
        )
      ]),
    );
  }
}
