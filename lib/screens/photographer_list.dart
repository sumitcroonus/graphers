import 'package:flutter/material.dart';
import 'package:graphers/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhotographerList extends StatefulWidget {
  const PhotographerList({super.key});

  @override
  State<PhotographerList> createState() => _PhotographerListState();
}

class _PhotographerListState extends State<PhotographerList> {
  List record = [];
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
    print("initstate123");
    super.initState();
    imagefromdb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // const SliverToBoxAdapter(
          // child: Center(
          //   child: CircularProgressIndicator(
          //     color: Colors.black54,
          //   ),
          // ),
          //   )
          SliverAppBar(
            backgroundColor: Colors.black87,
            expandedHeight: 200,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: record.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black54,
                      ),
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          record[1]["url"],
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black45,
                                Colors.black87,
                              ],
                              stops: [0.5, 1],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.repeated,
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 50),
          ),
          SliverFixedExtentList(
            itemExtent: 120,
            delegate: SliverChildListDelegate(List.generate(20, (index) {
              return Card(
                // child: ListTile(
                //   leading: CircleAvatar(
                //       radius: 25,
                //       backgroundImage: NetworkImage(
                //           'https://cdn-icons-png.flaticon.com/512/3135/3135715.png')),
                //   title: Text("name"),
                //   trailing: Icon(Icons.message),
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 22,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                "Subtitle is written here",
                                style: TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),
            // delegate: SliverChildBuilderDelegate((context, index) {
            //   return const Card(
            //     child: ListTile(
            //       leading: CircleAvatar(
            //         backgroundImage: NetworkImage(
            //           'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
            //         ),
            //       ),
            //       title: Text("name"),
            //       trailing: Icon(Icons.message),
            //     ),
            //   );
            // }),
          )
          // SliverToBoxAdapter(
          //   child: ListView.builder(
          //     itemCount: 10,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         leading: CircleAvatar(
          //             maxRadius: 20, backgroundColor: Colors.amber),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
