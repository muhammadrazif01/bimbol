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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          'Daftar Jadwal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            fontFamily: 'DancingScript1',
            color: Colors.white70,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Text('+'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddJadwal())).then((value) {
                  setState(() {
                    // refresh state of Page1
                  });
                });
        },
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
        //ADAPUN FUNGSI YANG DIJALANKAN ADALAH getEmployee() DARI EMPLOYEE_PROVIDER
        onRefresh: () => JadwalUtils().connectAPI(),
        child: Container(
          margin: const EdgeInsets.all(10),
          //KETIKA PAGE INI DIAKSES MAKA AKAN MEMINTA DATA KE API
          child: FutureBuilder<List<JadwalModel>>(
            future: data,
            builder: (context, projectSnap) {
              if (projectSnap.hasData) {
                return ListView.builder(
                  itemCount: projectSnap.data!
                      .length, //MENGHITUNG JUMLAH DATA YANG AKAN DITAMPILKAN
                  //LOOPING DATA
                  itemBuilder: (context, i) {
                    //KEMUDIAN TAMPILKAN DATA PEGAWAI BERDASARKAN INDEX YANG DISIMPAN DI DALAM VARIABLE I
                    return InkWell(
      onTap: () {
        //DIMANA KETIKA DI-TAP MAKA AKAN DIARAHKAN
        Navigator.of(context).push(
          //KE CLASS EMPLOYEEEDIT DENGAN MENGIRIMKAN ID EMPLOYEE
          MaterialPageRoute(
            builder: (context) => EditJadwal(id: projectSnap.data![i].id, j:projectSnap.data![i]),
          ),
        );
      },
      child: Card(
                      elevation: 8,
                      child: ListTile(
                        title: Text(
                          projectSnap.data![i].nama,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Kelas ${projectSnap.data![i].kelas}'),
                        trailing: Text("${projectSnap.data![i].hari}, ${projectSnap.data![i].start} - ${projectSnap.data![i].end}"),
                      ),
                    ),
    );
                  },
                );
              } else if (projectSnap.hasError) {
                return Text('${projectSnap.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
