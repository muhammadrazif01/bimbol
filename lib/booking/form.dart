import 'package:flutter/material.dart';
import 'package:pbpbimbol/booking/daftar_guru.dart';
// import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyBookingPageState();
  }
}

class MyBookingPageState extends State<MyBookingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List guru = ListPageState.listGuru;

  String input = "";
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: const Text("Booking Form"),
          // backgroundColor: Colors.teal[800],
        ),
        backgroundColor: const Color(0xff171941),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  hintText: 'Use Capital',
                  labelText: 'Teacher *',
                  fillColor: Colors.white,
                  
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (!guru.contains(value)) {
                    return value + " is unavailable!";
                  }
                  input = value;
                  return null;
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      http.post(
                          Uri.parse(
                              'https://tk-pbp-a01.herokuapp.com/booking/post_guru/'),
                          headers: <String, String>{
                            "Content-Type": "application/json;charset=UTF-8",
                          },
                          body: jsonEncode(<String, String>{
                            'guru': input,
                          }));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Successfully book " + input)),
                      );
                    }
                  },
                  child: const Text('Book'),
                ),
              ),
            ],
          ),
        ));
  }
}
