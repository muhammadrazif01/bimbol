import 'package:flutter/material.dart';
import '../models/jadwal_model.dart';
import 'add_jadwal.dart';
import 'edit_jadwal.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => Jadwal();
}

class Jadwal extends State<JadwalPage> {
  Future<List<JadwalModel>> data = JadwalUtils().connectAPI();

  @override
  Widget build(BuildContext context) {
    // print(JadwalUtils.isGuru);
    if (!JadwalUtils.isGuru) {
      return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: const Text(
              'Daftar Jadwal',
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: const Center(
              child: Text(
            'Silakan daftar/login menjadi guru terlebih dahulu',
            style: TextStyle(
              color: Colors.white,
            ),
          )));
    }
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          'Daftar Jadwal',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Text('+'),
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddJadwal()))
              .then((value) {
            setState(() {});
          });
        },
      ),
      body: RefreshIndicator(
        onRefresh: () => JadwalUtils().connectAPI(),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: FutureBuilder<List<JadwalModel>>(
            future: data,
            builder: (context, projectSnap) {
              if (projectSnap.hasData) {
                return ListView.builder(
                  itemCount: projectSnap.data!.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditJadwal(
                                id: projectSnap.data![i].id,
                                j: projectSnap.data![i]),
                          ),
                        );
                      },
                      child: Card(
                        color: const Color(0xff1f2251),
                        elevation: 8,
                        child: ListTile(
                          title: Text(
                            projectSnap.data![i].nama,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70),
                          ),
                          subtitle: Text('Kelas ${projectSnap.data![i].kelas}',
                              style: const TextStyle(color: Colors.white70)),
                          trailing: Text(
                              "${projectSnap.data![i].hari}, ${projectSnap.data![i].start} - ${projectSnap.data![i].end}",
                              style: const TextStyle(color: Colors.white70)),
                        ),
                      ),
                    );
                  },
                );
              } else if (projectSnap.hasError) {
                return Text('${projectSnap.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
