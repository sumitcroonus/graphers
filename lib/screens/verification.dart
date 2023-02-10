import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graphers/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verification extends StatelessWidget {
  final number;
  final String otp;
  Verification(this.number, this.otp, {super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  TextEditingController num3 = TextEditingController();
  TextEditingController num4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          foregroundColor: Colors.black),
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
                    color: Color.fromRGBO(199, 62, 29, 0.9)),
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
                          // fontFamily: 'Unbounded',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(199, 62, 29, 0.9)),
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
              child: Text(
                'Enter the OTP sent to +91 $number',
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 64,
                        width: 68,
                        child: TextFormField(
                          controller: num1,
                          textAlign: TextAlign.center,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Please enter 4 digit OTP";
                          //   }
                          //   return null;
                          // },
                          onChanged: (val) {
                            if (val.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: const TextStyle(fontSize: 30),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(199, 62, 29, 0.9),
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 64,
                        width: 68,
                        child: TextFormField(
                          controller: num2,
                          textAlign: TextAlign.center,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Please enter 4 digit OTP";
                          //   }
                          //   return null;
                          // },
                          onChanged: (val) {
                            if (val.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: const TextStyle(fontSize: 30),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(199, 62, 29, 0.9),
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 64,
                        width: 68,
                        child: TextFormField(
                          controller: num3,
                          textAlign: TextAlign.center,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Please enter 4 digit OTP";
                          //   }
                          //   return null;
                          // },
                          onChanged: (val) {
                            if (val.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: const TextStyle(fontSize: 30),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(199, 62, 29, 0.9),
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 64,
                        width: 68,
                        child: TextFormField(
                          controller: num4,
                          textAlign: TextAlign.center,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Please enter 4 digit OTP";
                          //   }
                          //   return null;
                          // },
                          onChanged: (val) {
                            if (val.length == 1) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                          style: const TextStyle(fontSize: 30),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(199, 62, 29, 0.9),
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final isValid = formKey.currentState?.validate();
                        formKey.currentState?.save();
                        if (isValid!) {
                          final enteredOtp =
                              num1.text + num2.text + num3.text + num4.text;
                          // debugPrint(enteredOtp);
                          // print(number.runtimeType);
                          if (enteredOtp == otp) {
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString('phoneNo', number);
                            Get.to(() => const HomeScreen());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text("Incorrect OTP"),
                              ),
                            );
                          }
                        }

                        num1.clear();
                        num2.clear();
                        num3.clear();
                        num4.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          backgroundColor:
                              const Color.fromRGBO(199, 62, 29, 0.9)),
                      child: const Text(
                        'Verify',
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
}
