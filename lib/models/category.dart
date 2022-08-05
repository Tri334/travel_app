import 'package:flutter/material.dart';
import 'package:travel_app/models/travel_icons_icons.dart';

class CateogryIcons {
  Icon icon;
  Color color;

  CateogryIcons({
    required this.icon,
    required this.color,
  });
}

var categoryIcons = [
  CateogryIcons(
    icon: const Icon(
      TravelIcons.flight,
      color: Color(0xff436DFF),
    ),
    color: const Color.fromRGBO(67, 109, 255, 0.1),
  ),
  CateogryIcons(
    icon: const Icon(
      TravelIcons.hotel,
      color: Color(0xffFF5D5D),
    ),
    color: const Color.fromRGBO(255, 93, 93, 0.1),
  ),
  CateogryIcons(
    icon: const Icon(
      TravelIcons.food,
      color: Color(0xffFFA41B),
    ),
    color: const Color.fromRGBO(255, 164, 27, 0.1),
  ),
  CateogryIcons(
    icon: const Icon(
      TravelIcons.event,
      color: Color(0xff61DE84),
    ),
    color: const Color.fromRGBO(97, 222, 132, 0.1),
  ),
];
