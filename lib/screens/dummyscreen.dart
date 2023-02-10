import 'package:flutter/material.dart';

class dummy extends StatelessWidget {
  const dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 400,
              color: Colors.amber,
            )
          ]),
        ),
        Container(
          child: Text("data"),
        )
      ]),
    );
  }
}
