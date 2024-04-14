import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  final carouselController = CarouselController();
  int currentIndex = 0;

  List<String> images = [
    'images/banner1.jpg',
    'images/banner2.jpg',
    'images/banner3.jpg',
    'images/banner4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: images.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 900,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20.0),
        //dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((image) {
            int index = images.indexOf(image);
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == index
                    ? const Color(0xFF860D9A)
                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
