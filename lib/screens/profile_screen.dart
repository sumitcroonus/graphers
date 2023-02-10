import 'package:flutter/material.dart';

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
                padding: EdgeInsets.only(bottom: 70),
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
            child: Text("name"),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.amber,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.pink,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.amber,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.pink,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.amber,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.pink,
          ),
        ),
      ],
    ));
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
          backgroundImage: NetworkImage(
            "https://i.pinimg.com/236x/af/9f/1f/af9f1fed99621ae20f9edd2ab6cbb8bd.jpg",
          ),
        ),
      );
}
