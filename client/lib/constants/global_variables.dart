import 'package:flutter/material.dart';

String uri = 'https://demo-homelyf.onrender.com';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 213, 222, 239),
      Color.fromARGB(255, 213, 222, 239),
    ],
    stops: [0.5, 1.0],
  );
  static const buttonGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 130, 188, 254),
      Color.fromARGB(255, 38, 112, 216),
    ],
    stops: [0.3, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 86, 145, 255);
  static const backgroundColor = Colors.white;
  static const titleColor = Color.fromARGB(255, 76, 139, 198);
  static const subTitleColor = Color.fromARGB(255, 73, 104, 141);
  static const textColor = Color.fromARGB(255, 119, 123, 130);
  static const labelColor = Color.fromARGB(255, 147, 147, 147);
  static const hintColor = Color.fromARGB(255, 147, 147, 147);
  static const Color greyBackgroundColor = Color.fromARGB(255, 122, 122, 122);
  static var selectedNavBarColor = const Color.fromARGB(255, 75, 141, 198);
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://englandscoast.com/inc/img/cache/media/ZqmWZEOXtv4HyFe4On9lO7gNvLU6z0Kb0yt2cyg3-image(1500x500-crop).jpeg',
    'https://s3.amazonaws.com/mychurchwebsite/images/c6938/hl_bp6c5b_crop.jpg',
    'https://theyamazakihome.com/cdn/shop/collections/nav2_256x256_19952094-967b-4d08-80f7-ac893994896f.png?v=1667248610',
    'https://www.wf-vision.com/wp-content/uploads/2021/02/01ThymeHohokusHomeOfficeFull_10PeterRymwid-1500x500.jpg',
    'https://theyamazakihome-europe.com/cdn/shop/files/Shop_All_Collections_3x1_round1.jpg?v=1659444353',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Cleaning',
      'image': 'assets/images/cleaning.png',
    },
    {
      'title': 'Plumbing',
      'image': 'assets/images/plumbing.png',
    },
    {
      'title': 'Electrician',
      'image': 'assets/images/electrician.png',
    },
    {
      'title': 'Gardening',
      'image': 'assets/images/gardening.png',
    },
    {
      'title': 'Carpentry',
      'image': 'assets/images/carpentry.png',
    },
  ];
}
