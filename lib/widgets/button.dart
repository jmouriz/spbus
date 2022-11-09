import 'package:flutter/material.dart';
import 'package:spbus/themes/themes.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required GlobalKey<ScaffoldState> scaffold,
    required IconData icon,
  }) : _key = scaffold, _icon = icon, super(key: key);

  final IconData _icon;
  final GlobalKey<ScaffoldState> _key;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 2,
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      child: InkWell(
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(
            _icon,
            color: greenTheme,
          ),
        ),
        onTap: () {
          print('tap');
          if (_key.currentState!.isDrawerOpen) {
            _key.currentState!.closeDrawer();
          } else {
            _key.currentState!.openDrawer();
          }
        },
      ),
    );
  }
}