import 'package:flutter/material.dart';

Color color(String color) {
  switch (color) {
    case 'blue':
      return Colors.blue;
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'magenta':
      return const Color.fromARGB(255, 241, 6, 194);
    case 'violet':
      return const Color.fromARGB(255, 153, 0, 235);
    case 'grey':
      return Colors.grey;
    case 'black':
      return Colors.black;
    case 'teal':
      return Colors.teal;
  }
  return Colors.black;
}