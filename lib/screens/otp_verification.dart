import 'package:flutter/material.dart';

import 'package:graphers/screens/verification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController num = TextEditingController();
  // String otp1 = '';
  Future register() async {
    final response = await http
        .post(
      //Uri.parse('http://192.168.240.1/api_photo/login.php'),
      Uri.parse('http://115.244.240.2:8084/login.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'PhoneNo': num.text}),
    )
        .then((value) {
      if (value.statusCode == 200) {
        final otp = json.decode(value.body);
        // print(otp.runtimeType);
        print(otp);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Verification(num.text, otp)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'OTP',
                style: TextStyle(
                    fontFamily: 'Unbounded',
                    fontSize: 30,
                    // fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(199, 62, 29, 0.7)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                children: const [
                  Text(
                    'VERIFICATION',
                    style: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontFamily: 'Unbounded',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(199, 62, 29, 0.7)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              alignment: Alignment.center,
              child: const Text(
                'We will send you a one time password on this Mobile Number',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: globalFormKey,
              child: Column(
                children: [
                  TextFormField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    style: const TextStyle(fontSize: 19, letterSpacing: 1.5),
                    controller: num,
                    //onSaved: (newValue) => _number = newValue!,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "please enter your Mobile Number";
                      } else if (val.length < 10 || val.length >= 11) {
                        return "Please enter valid Mobile Number ";
                      }
                    },
                    decoration: InputDecoration(
                      // prefixText: String.fromEnvironment('+91'),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(199, 62, 29, 0.7),
                          width: 2,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                      label: Text("Mobile Number",
                          style: TextStyle(color: Colors.grey[900])),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        submit();
                      },
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          backgroundColor:
                              const Color.fromRGBO(199, 62, 29, 0.7)),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    final isValid = globalFormKey.currentState?.validate();

    if (isValid!) {
      globalFormKey.currentState?.save();
      register();
    }
  }
}
