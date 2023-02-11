import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                )
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
          const SliverToBoxAdapter(
              child: Center(
            child: Text("realmadrid\nfc 13times champions league"),
          )),
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
                  onPressed: () {},
                  child: const Text("Edit bio"),
                ),
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
                return Container(
                  color: Colors.black54,
                );
              },
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
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final imageTemporary = File(pickedImage.path);
      print(imageTemporary);
      setState(() {
        _image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed to pick image');
    }
  }

  Future upload() async {
    final uri = Uri.parse("http://192.168.1.65/api_photo/upload_image.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields["caption"] = caption.text;
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
        title: Text("New Post"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                child: Column(
                  children: [
                    Container(
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
                setState(() {
                  upload();
                  Navigator.of(context).pop();
                });
              },
              child: Text("Post"))
        ]);
  }
}
