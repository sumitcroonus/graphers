import 'package:flutter/material.dart';

class Category {
  final String title;
  final String url;
  final String location;

  const Category({
    required this.title,
    required this.url,
    required this.location,
  });
}

const dummy = [
  Category(
    url:
        "https://cdn0.weddingwire.in/article/1992/3_2/960/jpg/102991-destination-weddings-in-india-lead.jpeg",
    title: "Wedding",
    location: "Nashik",
  ),
  Category(
    url:
        "https://assets.vogue.com/photos/6047ecd6d88afccceb883b64/master/w_3000,h_2000,c_limit/Paris%20Fall%2021%20day%208%20by%20STYLEDUMONDE%20Street%20Style%20Fashion%20Photography_95A7181FullRes.jpg",
    title: "Street",
    location: "Mumbai",
  ),
  Category(
    url:
        "https://antphotography.in/wp-content/uploads/2022/07/DSC02568-Edit-1080x675.jpg",
    title: "PreWedding",
    location: "Pune",
  ),
  Category(
    url:
        "https://www.photojaanic.com/blog/wp-content/uploads/sites/2/2022/01/image9-1.jpg",
    title: "BabyShower",
    location: "Assam",
  ),
  Category(
    url:
        "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmVzdGl2YWx8ZW58MHx8MHx8&w=1000&q=80",
    title: "Festivals",
    location: "Goa",
  ),
  Category(
    url:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt75aIOPX1rmVYHzKKVDpVM-pAymOLO6Hncowaf7DwX1ptB1dQzQnmGbDNFIlbYJtt0gg&usqp=CAU",
    title: "Portfolio",
    location: "Kerala",
  ),
];
