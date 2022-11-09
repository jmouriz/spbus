import 'package:flutter/material.dart';

class BusIcon extends StatelessWidget {
  const BusIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( 
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16) 
      ),
      child: const Icon(
        Icons.directions_bus,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
