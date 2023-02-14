import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:graphers/screens/photographer_registeration_scrren.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List pics = [];
  Future<void> getPosts() async {
    try {
      final response =
          await http.get(Uri.parse("http://192.168.1.65/api_photo/posts.php"));

      if (response.statusCode == 200) {
        setState(() {
          pics = jsonDecode(response.body);
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    getPosts();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: buildCoverImage(),
                ),
                Positioned(
                  top: 235,
                  child: buildProfileImage(),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Name",
                  style: TextStyle(fontSize: 22),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog();
                      },
                    );
                  },
                  child: const Text("New post"),
                ),
                OutlinedButton(
                    onPressed: () async {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.remove('mobileNo');
                      Get.to(() => const PhotographerVerificationScreen());
                    },
                    child: const Text("Log out"))
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 2,
              childAspectRatio: 0.90,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return InkWell(
                  child: pics.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(199, 62, 29, 0.6),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://192.168.1.65/api_photo/uploads/" +
                                      pics[index]["image_url"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                );
              },
              childCount: pics.length,
            ),
          ),
        ],
      ),
    );
  }

  buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
            "https://i.pinimg.com/564x/6d/5c/47/6d5c47a59c6463440d28fceb05c37201.jpg",
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover),
      );

  buildProfileImage() => CircleAvatar(
        radius: 68,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 65,
          backgroundColor: Colors.grey.shade800,
          backgroundImage: const NetworkImage(
            "https://i.pinimg.com/236x/af/9f/1f/af9f1fed99621ae20f9edd2ab6cbb8bd.jpg",
          ),
        ),
      );
}

class Dialog extends StatefulWidget {
  const Dialog({super.key});

  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  File? _image;

  final TextEditingController caption = TextEditingController();

  Future choiceImage() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
      print(_image);
    });
  }

  Future upload() async {
    final uri = Uri.parse("http://192.168.1.65/api_photo/upload_image.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['caption'] = caption.text;
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image uploaded");
    } else {
      print("image not uploaded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("New Post"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 250,
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : const Text("Select image"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        choiceImage();
                      },
                      child: const Text(
                        "add photo",
                      ),
                    ),
                    TextField(
                      controller: caption,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(labelText: "Caption"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                upload();
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              child: const Text("Post"))
        ]);
  }
}
