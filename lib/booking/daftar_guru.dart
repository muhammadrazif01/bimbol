import 'package:flutter/material.dart';
import 'package:pbpbimbol/booking/form.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListPageState();
  }
}

class ListPageState extends State<ListPage> {
  static List listGuru = [];
  Future<List<Guru>> getGuru() async {
    var data = await http
        .get(Uri.parse('https://tk-pbp-a01.herokuapp.com/booking/get_guru/'));

    var jsonData = json.decode(data.body);

    List<Guru> daftarGuru = [];

    for (var i in jsonData) {
      Guru guru = Guru(i["nama_guru"], i["mata_pelajaran"], i["jenis_kelamin"]);
      daftarGuru.add(guru);
      listGuru.add(i["nama_guru"]);
    }
    return daftarGuru;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Booking Guru"),
          backgroundColor: Colors.teal[800],
        ),
        body: Center(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: ListView(children: [
                  FutureBuilder<List<Guru>>(
                      future: getGuru(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return cardBuild(
                                  snapshot.data[index].nama,
                                  snapshot.data[index].kelamin,
                                  snapshot.data[index].mapel);
                            },
                          );
                        }
                      }),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton.extended(
                      extendedPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyBookingPage(),
                            ));
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Book"),
                    ),
                  ),
                ]))));
  }

  Card cardBuild(String nama, String jenis, String mapel) {
    String imageLink = "";
    if (jenis.contains('p')) {
      imageLink =
          "https://images.ctfassets.net/usf1vwtuqyxm/1dmmUJzpRcWaUmMOCu8QwO/7e013145694566076d47fd004fd604c2/AlbusDumbledore_WB_F6_DumbledoreSittingInChair_Promo_080615_Port.jpg?fm=jpg&q=70&w=2560";
    } else {
      imageLink =
          "data:image/jpeg;base64,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";
    }
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        SizedBox(
          height: 200.0,
          child: Ink.image(
            image: NetworkImage(imageLink),
            fit: BoxFit.contain,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
          alignment: Alignment.centerLeft,
          child: Text(nama),
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        //     alignment: Alignment.centerLeft,
        //     child:
        //     Text(jenis),
        // ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text(mapel),
        ),
      ]),
    );
  }
}

class Guru {
  final String nama;
  final String mapel;
  final String kelamin;

  Guru(this.nama, this.mapel, this.kelamin);

  Guru.fromJson(Map<String, dynamic> jsonGuru)
      : nama = jsonGuru['nama_guru'],
        mapel = jsonGuru['mata_pelajaran'],
        kelamin = jsonGuru['jenis_kelamin'];
}
