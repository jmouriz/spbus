import 'package:flutter/material.dart';
import 'package:spbus/themes/themes.dart';
import 'package:spbus/widgets/home.dart';

/*
  <uses-permission android:name="android.permission.INTERNET" />
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

  <key>NSLocationWhenInUseUsageDescription</key>
	<string>SPBus necesita conocer tu ubicación para mostrarla en el mapa</string>
 */

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //  statusBarColor: Colors.blue, // transparent status bar
  //  systemNavigationBarColor: Colors.black, // navigation bar color
  //  statusBarIconBrightness: Brightness.dark, // status bar icons' color
  //  systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
  //  statusBarBrightness: Brightness.dark,
  //));
  //runApp(const MediaQuery(data: MediaQueryData(), child: Application()));
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SPBus',
      theme: ThemeData(
        primarySwatch: greenTheme, 
      ),
      home: HomeWidget(),
    );
  }
}
