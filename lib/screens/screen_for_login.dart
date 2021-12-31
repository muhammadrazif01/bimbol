// import package and library needed
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import supporting files for login
import '../../main.dart' as main;
import 'user_session_support.dart' as user;
import '../screens/homepage.dart' as homepage;
import '../screens/homepage.dart' as logout;

// create a login screen class
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// create the state for login screen
class _LoginScreenState extends State<LoginScreen> {

  // create a global login key
  final _loginKey = GlobalKey<FormState>();

  // create a variable to store username and password of user
  String username = "";
  String password = "";

  // initialize boolean and function to show or hide password
  bool showPassword = true;
  void showOnOff() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  // override build method
  @override
  Widget build(BuildContext context) {

    // use scaffold to handle things inside
    return Scaffold(

      // set background color first
      backgroundColor: const Color(0xff171941),

      // set appbar to help user aware of what page they are currently on. set the alignment, color, and style as well
      appBar: AppBar(
        title: const Text(
          'Masuk dan Keluar',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xff171941),
        centerTitle: true,
      ),

      // create the body part using single child scroll view
      body: SingleChildScrollView(

        // create a container and add padding to it to make it look aesthetically pleasing
        child: Container(
          padding: const EdgeInsets.all(25),

          // create column child to help layouting the page
          child: Column(
            children: <Widget>[

              // create the form for login with _loginKey as key. create another column child to help layouting the page
              Form(
                key: _loginKey,
                child: Column(
                  children: [

                    // create a container to store user's username and validate it to make sure user fill it
                    Container(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderSide:BorderSide(color: Colors.white, width: 40)),
                          hintText: 'Masukkan username anda!',
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Raleway", color: Colors.white),
                        ),
                        onChanged: (String value) {username = value;},
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username wajib diisi!";
                          }
                        },
                      ),
                      decoration: const BoxDecoration(color: Color(0xff724580)),
                    ),
                    const SizedBox(height: 12),

                    // create a container to store user's password
                    Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide:BorderSide(color: Colors.white, width: 40)),
                            hintText: 'Masukkan password anda!',
                            hintStyle: const TextStyle(fontStyle: FontStyle.italic, fontFamily: "Raleway", color: Colors.white),
                            suffixIcon: IconButton(
                              color: const Color(0xffc8a2c8),
                              icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: showOnOff)),
                          onChanged: (String value) {password = value;},
                          obscureText: !showPassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password wajib diisi!";
                            }
                          },
                        ),
                      decoration: const BoxDecoration(color: Color(0xff724580)),
                    ),
                    const SizedBox(height: 65),

                    // create container for login button
                    Container(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                        onPressed: () async {
                          if (_loginKey.currentState!.validate()) {
                            final response = await http.post(Uri.parse("https://tk-pbp-a01.herokuapp.com/jsonApp"),
                                headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
                                body: jsonEncode(<String, String>{'username': username, 'password': password}));
                            dynamic jsondata = await jsonDecode(response.body);
                            if (jsondata["session"] == "logged in") {
                              user.user.insert(0, jsondata);
                              print("Berhasil masuk!");
                            }
                          }
                        },
                        child: const Text("Masuk", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)))),
                    const SizedBox(height: 12),

                    // create container for logout botton
                    Container(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                            onPressed: () async {
                              if (_loginKey.currentState!.validate()) {
                                final response = await http.post(Uri.parse("https://tk-pbp-a01.herokuapp.com/jsonApp"),
                                    headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'},
                                    body: jsonEncode(<String, String>{'username': username, 'password': password}));
                                dynamic jsondata = await jsonDecode(response.body);
                                if (jsondata["session"] == "logged in") {
                                  user.user.insert(0, {'status': "not logged in"});
                                  print("Berhasil keluar!");
                                }
                              }
                            },
                            child: const Text("Keluar", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}