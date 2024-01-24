import 'package:flutter/material.dart';
import 'package:login_screen/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  signout(context);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Text('Keep smiling :)'),
          ),
        ));
  }

  signout(BuildContext context) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ScreenLogin()),
      (route) => false,
    );
  }
}
