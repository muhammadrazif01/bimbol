import 'package:flutter/material.dart';
import 'package:pbpbimbol/forum/screens/detail.dart';

class Kartu extends StatelessWidget {
  final int id;
  final String judul;
  final String desc;
  final String created;
  final String author;

  const Kartu(this.id, this.judul, this.desc, this.created, this.author,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color(0xff1f2251),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Detail(id, judul, desc, created, author)),
            );
          },
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'created by $author at ${created.substring(0, 10)} ${created.substring(11, 16)}',
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'DancingScript1',
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
