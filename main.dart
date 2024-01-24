import 'package:flutter/material.dart';
import 'Screens/splash.dart';

const SAVE_KEY_NAME = 'UserLoggedIn';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginSample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenSplash(),
    );
  }
}
