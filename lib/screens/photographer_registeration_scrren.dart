import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:graphers/screens/home.dart';
import 'package:graphers/screens/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PhotographerVerificationScreen extends StatefulWidget {
  const PhotographerVerificationScreen({super.key});

  @override
  State<PhotographerVerificationScreen> createState() =>
      _PhotographerVerificationScreenState();
}

class _PhotographerVerificationScreenState
    extends State<PhotographerVerificationScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController num = TextEditingController();
  bool buisness = true;
  String? mobileNo;
  Future register() async {
    final response = await http.post(
      //Uri.parse('http://192.168.240.1/api_photo/login.php'),
      Uri.parse('http://192.168.1.65/api_photo/registerphotographer.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
          {'Name': name.text, 'Email': email.text, 'PhoneNo': num.text}),
    );
  }

  @override
  void initState() {
    super.initState();
    Future getValidationData() async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var obtainedPhoneNo = sharedPreferences.getString('phoneNo');
      if (mobileNo == null) {
      } else {
        print(mobileNo);
        Get.to(() => const Profile());
      }
      setState(() {
        mobileNo = obtainedPhoneNo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            fontFamily: 'Unbounded',
                            fontSize: 30,
                            color: Color.fromRGBO(199, 62, 29, 0.7)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "With us and get more customers!",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Form(
                      key: globalFormKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            style: const TextStyle(
                                fontSize: 19, letterSpacing: 1.5),
                            controller: name,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "please enter your Name";
                              } else if (val.length < 3) {
                                return "Please enter Full Name ";
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
                              label: Text("Name",
                                  style: TextStyle(color: Colors.grey[900])),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            style: const TextStyle(
                                fontSize: 19, letterSpacing: 1.5),
                            controller: email,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (EmailValidator.validate(val!)) {
                                return null;
                              } else {
                                return "Please enter valid Email address. ";
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
                              label: Text("Email",
                                  style: TextStyle(color: Colors.grey[900])),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            style: const TextStyle(
                                fontSize: 19, letterSpacing: 1.5),
                            controller: num,
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
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          final isValid =
                              globalFormKey.currentState?.validate();
                          if (isValid!) {
                            globalFormKey.currentState?.save();
                            register();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Profile(),
                                ));
                            // final SharedPreferences sharedPreferences =
                            //     await SharedPreferences.getInstance();
                            // sharedPreferences.setString('mobileNo', num.text);
                            // Get.to(() => const Profile());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor:
                                const Color.fromRGBO(199, 62, 29, 0.7)),
                        child: const Text(
                          'Create',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 40,
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 2))),
              padding: const EdgeInsets.only(top: 7, bottom: 7),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                    width: 50,
                    child: FlutterSwitch(
                      activeColor: const Color.fromRGBO(199, 62, 29, 0.6),
                      value: buisness,
                      onToggle: (val) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                        setState(() {
                          buisness = !buisness;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Buisness..",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
