import 'package:flutter/material.dart';
import 'package:login_screen/Screens/home.dart';
import 'package:login_screen/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();
  bool _isDataMatched = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Username'),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Password'),
            validator: (value) {
              //if (_isDataMatched) {
              //  return null;
              //} else {
              //   return 'error';
              //}
              if (value == null || value.isEmpty) {
                return 'Value is empty';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                  visible: !_isDataMatched,
                  child: Text('Username and Password does not match',
                      style: TextStyle(color: Colors.red))),
              ElevatedButton.icon(
                onPressed: () {
                  _formKey.currentState!.validate();
                  checkLogin(context);
                },
                icon: Icon(Icons.check),
                label: Text('Login'),
              )
            ],
          ),
        ]),
      ),
    )));
  }

  Future<void> checkLogin(BuildContext context) async {
    final _username = _usernameController.text;
    final _password = _passwordController.text;
    if (_username == _password) {
      //GO TO HOMEPAGE
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(SAVE_KEY_NAME, true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ScreenHome()));
    } else {
      final _errorMessage = 'Username and password does not match';
      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          margin: EdgeInsets.all(10),
          content: Text(_errorMessage)));

      //Popup(Alert dialogue)

      showDialog(
          context: context,
          builder: (context1) {
            return AlertDialog(
              title: Text('Error!'),
              content: Text(_errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context1).pop();
                  },
                  child: Text('Close'),
                )
              ],
            );
          });

      //Show Text
      setState(() {
        _isDataMatched = false;
      });
    }
  }
}
