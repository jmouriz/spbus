
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spbus/themes/themes.dart';
import 'package:spbus/widgets/button.dart';
import 'package:spbus/widgets/drawer.dart';
import 'package:spbus/widgets/map.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({ super.key });

  final GlobalKey<ScaffoldState> _key = GlobalKey(); 

  @override
  Widget build(BuildContext context) {
    final double top = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      // SystemUiOverlayStyle.dark,                
      child: Scaffold(
        key: _key,
        drawer: DrawerWidget(scaffold: _key),
        body: Stack(
          children: [
            MapWidget(),
            Container(
              height: top,
              width: double.infinity,
              color: greenTheme.withOpacity(0.25),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, top: top + 8),
              child: ButtonWidget(
                icon: Icons.menu,
                scaffold: _key
              ),
            )
          ],
        )
      ),
    );
  }
}