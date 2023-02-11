import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:graphers/screens/photographer_list.dart';
import 'package:graphers/screens/photographer_registeration_scrren.dart';
import 'package:graphers/screens/profile_screen.dart';
import 'package:graphers/widgets/carousel.dart';
import 'package:graphers/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool buisness = false;
  List record = [];
  String? mobileNo;
  Future<void> imagefromdb() async {
    try {
      var response = await http
          .get(Uri.parse('http://192.168.1.65/api_photo/categories.php'));
      if (response.statusCode == 200) {
        setState(() {
          record = jsonDecode(response.body);
          // print(record);
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    // print("initstate home");
    super.initState();
    imagefromdb();
    validate();
  }

  Future validate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileNo = prefs.getString("mobileNo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Home',
      //     style: TextStyle(fontSize: 25),
      //   ),
      //   backgroundColor: const Color.fromRGBO(199, 62, 29, 0.6),
      //   elevation: 0,
      //   foregroundColor: Colors.white,
      // ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: const [
                MyDrawer(),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.black87,
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      "https://assets.theedgemarkets.com/investing-in-photography_20171107154222_theedgemarkets.jpg",
                      fit: BoxFit.cover,
                    ),
                    title: const Text("Graphers"),
                  ),
                  // title: const Text("Graphers"),
                ),
                const SliverToBoxAdapter(child: Carousel()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Row(
                      children: const [
                        Text(
                          "In the ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 27,
                              color: Colors.black87),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Spotlight...",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromRGBO(199, 62, 29, 0.6),
                              fontFamily: 'Unbounded'),
                        )
                      ],
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 0,
                    childAspectRatio: 0.90,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PhotographerList(),
                            ),
                          );
                        },
                        child: record.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(199, 62, 29, 0.6),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blueGrey,
                                  image: DecorationImage(
                                      image: NetworkImage(record[index]["url"]),
                                      fit: BoxFit.cover),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 30,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.black54,
                                    ),
                                    child: Text(
                                      record[index]["name"],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                      );
                    },
                    childCount: record.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Most ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 27,
                                  color: Colors.black87),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Viewed...",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromRGBO(199, 62, 29, 0.6),
                                  fontFamily: 'Unbounded'),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const Image(
                              image: NetworkImage(
                                "https://images.squarespace-cdn.com/content/v1/588770911b631b203a2d6167/1487713615445-IF4GU4GHMN8UA9CPOIKB/36-satnam+photography+spain+destination+wedding+indian+wedding+photography-2.jpg?format=2500w",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 2))),
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
                    value: false,
                    onToggle: (val) {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const PhotographerVerificationScreen()),
                      // );
                      if (mobileNo == null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PhotographerVerificationScreen()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Profile(),
                          ),
                        );
                      }
                      setState(() {
                        buisness = true;
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
    );
  }
}
