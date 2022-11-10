import 'package:flutter/material.dart';
import 'package:spbus/themes/themes.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white.withOpacity(0.25),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(greenTheme),
          ),
        ),
      ),
    );
  }
}