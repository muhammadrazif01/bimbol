// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const myApp());
}

// ignore: camel_case_types
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[900]),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }

  
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _regFormKey = GlobalKey<FormState>();

  String username = "";
  String password1 = "";
  String password2 = "";
  String email = "";
  String nama_lengkap = "";
  String nomor_telefon = "";

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:const BoxConstraints() ,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: const Text('Hello',
                    style: TextStyle(
                    fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                  ),
                  const SizedBox(height:10.0),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                    child: const Text( 'Teacher',
                    style: TextStyle(
                    fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(310.0, 175.0, 0.0, 0.0),
                    child: const Text('.',
                    style: TextStyle(
                    fontSize: 80.0, fontWeight: FontWeight.bold,color: Colors.green)
                    ),
                  )
                ],
              ),
              Form(
            key: _regFormKey,
            child:Column(
              children:<Widget> [
                TextFormField(
                  onChanged: (value){
                    username=value;
                  },
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'USERNAME',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                    )
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value){
                    password1=value;
                  },
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white
                  ),
                  decoration: const InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                    )
                  ),
                  obscureText: true,
                ),
                TextFormField(
                  onChanged: (value){
                    password2=value;
                  },
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'CONFIRM PASSWORD',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                    )
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value){
                    email=value;
                  },
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                    )
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value){
                    nama_lengkap=value;
                  },
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'NAMA LENGKAP',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                    )
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value){
                    nomor_telefon=value;
                  },
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'NOMOR TELEFON',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                    )
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],)
          ),
            ElevatedButton(
              onPressed: () async{
                if (_regFormKey.currentState!.validate()){
                  final response = await http.post(
                    Uri.parse("https://tk-pbp-a01.herokuapp.com/pendaftaranguru/"),
                    headers: <String, String>{
                          "Content-Type": "application/json;charset=UTF-8",
                    },
                    body: jsonEncode(<String, String>{
                      'username': username,
                      'password1' : password1,
                      'password2' : password2,
                      'email' : email,
                      'nama_lengkap' : nama_lengkap,
                      'nomor_telefon' : nomor_telefon
                    })
                  );
                  final resp = jsonDecode(response.body);
                      if (resp['status'] == 'success') {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        */
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Register Failed')));
                      }
                }
              },
              child: const Text("REGISTER"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    alignment: Alignment.center,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(15),
                  ),


            ),
        const SizedBox(height: 50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Not A Teacher?',
              style: TextStyle(
                fontFamily: 'Montserrat', color: Colors.white
              ),
            ),
            const SizedBox(width: 1.0,),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: const Text('Register Murid',
              style: TextStyle(
                color: Colors.green,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              ),
              ),
            )
          ],
        )
            ],
            
          )
    )
    )
    );
}
