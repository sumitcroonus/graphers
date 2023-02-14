import 'package:flutter/material.dart';

class dummy extends StatelessWidget {
  const dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
              child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                // padding: EdgeInsets.only(bottom: 100),
                height: 300,
                color: Colors.amber,
              ),
              const Positioned(
                  top: 240,
                  left: 40,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.pink,
                  ))
            ],
          )),
          const SizedBox(
            height: 70,
          ),
          Card(
            shadowColor: Colors.pink,
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black87,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
