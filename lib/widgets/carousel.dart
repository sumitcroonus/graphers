import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List record = [];
  // List<Category> categories = dummy;
  Future<void> imagefromdb() async {
    var response = await http
        .get(Uri.parse('http://192.168.1.65/api_photo/get_image.php'));
    if (response.statusCode == 200) {
      setState(() {
        record = jsonDecode(response.body);
        // print(record);
      });
    }
  }

  @override
  void initState() {
    print("initstate");
    super.initState();
    imagefromdb();
  }

  @override
  Widget build(BuildContext context) {
    return caro();
  }

  Container caro() {
    return Container(
      // decoration: const BoxDecoration(
      //     color: Colors.black54,
      //     borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: const [
                Text(
                  "In",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 27,
                      color: Colors.black87),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Focus...",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromRGBO(199, 62, 29, 0.6),
                      fontFamily: 'Unbounded'),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            child: CarouselSlider.builder(
                itemCount: record.length,
                // itemCount: categories.length,
                itemBuilder: (context, index, id) {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: record.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(199, 62, 29, 0.6),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 5.0)
                                ],
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.white),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      record[index]["image_url"],
                                      // categories[index].url,
                                      width: 500,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        color: Colors.black54,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              record[index]["title"],
                                              // categories[index].title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.add_location,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  record[index]["location"],
                                                  // categories[index].location,
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  );
                },
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 300,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
