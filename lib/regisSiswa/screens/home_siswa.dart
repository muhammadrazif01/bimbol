import 'package:flutter/material.dart';

class homeSiswa extends StatefulWidget {
  homeSiswa({Key? key}) : super(key: key);

  @override
  _homeSiswaState createState() => _homeSiswaState();
}

class _homeSiswaState extends State<homeSiswa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BIMBOL"),
          centerTitle: true,
        ),
        body: Container(
          color: Color.fromARGB(255, 23, 25, 65),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Bimbol",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ));
  }
}
