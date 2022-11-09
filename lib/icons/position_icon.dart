import 'package:flutter/material.dart';

class PositionIcon extends StatelessWidget {
  const PositionIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( 
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16) 
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
