import 'package:flutter/cupertino.dart';
import 'package:travel_app/models/travel_icons_icons.dart';

class ImageStorage {
  String image;
  ImageStorage({required this.image});
}

var images = [ImageStorage(image: 'assets/images/landing_image.png')];

class DummyImage {
  String image;
  DummyImage({required this.image});
}

var dummyImages = [
  ImageStorage(image: 'assets/images/landing_image.png'),
  ImageStorage(image: 'assets/images/landing_image.png'),
  ImageStorage(image: 'assets/images/landing_image.png'),
  ImageStorage(image: 'assets/images/landing_image.png'),
  ImageStorage(image: 'assets/images/landing_image.png'),
  ImageStorage(image: 'assets/images/landing_image.png'),
];

var dummyStar = [
  const Icon(
    TravelIcons.star,
    color: Color.fromRGBO(231, 109, 129, 0.5),
  ),
  const Icon(
    TravelIcons.star,
    color: Color.fromRGBO(231, 109, 129, 0.5),
  ),
  const Icon(
    TravelIcons.star,
    color: Color.fromRGBO(231, 109, 129, 0.5),
  ),
  const Icon(
    TravelIcons.star,
    color: Color.fromRGBO(231, 109, 129, 0.5),
  ),
  const Icon(
    TravelIcons.star,
    color: Color.fromRGBO(231, 109, 129, 0.5),
  ),
];

var dummyStar2 = [
  const Icon(
    TravelIcons.star,
    color: Color(0xffE76D81),
  ),
  const Icon(
    TravelIcons.star,
    color: Color(0xffE76D81),
  ),
  const Icon(
    TravelIcons.star,
    color: Color(0xffE76D81),
  ),
];
