import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      theme: new ThemeData(scaffoldBackgroundColor: Colors.grey[900]),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }

  
}

class MyHomePage extends StatefulWidget {
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
          constraints:BoxConstraints() ,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text('Hello',
                      style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                    SizedBox(height:10.0),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                      child: Text( 'Teacher',
                      style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(310.0, 175.0, 0.0, 0.0),
                      child: Text('.',
                      style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold,color: Colors.green)
                      ),
                    )
                  ],
                ),
              ),
              Form(
            key: _regFormKey,
            child:Column(
              children:<Widget> [
                TextFormField(
                  onChanged: (value){
                    username=value;
                  },
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
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
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value){
                    password1=value;
                  },
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
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
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
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
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value){
                    email=value;
                  },
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
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
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value){
                    nama_lengkap=value;
                  },
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
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
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value){
                    nomor_telefon=value;
                  },
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
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
                SizedBox(
                  height: 20.0,
                ),
              ],)
          ),
            Container(
            child: ElevatedButton(
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
              child: Text("REGISTER"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    alignment: Alignment.center,
                    shape: StadiumBorder(),
                    padding: EdgeInsets.all(15),
                  ),


            ),
        ),
        SizedBox(height: 50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Not A Teacher?',
              style: TextStyle(
                fontFamily: 'Montserrat', color: Colors.white
              ),
            ),
            SizedBox(width: 1.0,),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: Text('Register Murid',
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
