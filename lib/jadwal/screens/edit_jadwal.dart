import 'package:flutter/material.dart';
import '../models/jadwal_model.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EditJadwal extends StatelessWidget {
  final String id;
  JadwalModel j;
  EditJadwal({Key? key, required this.id, required this.j}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Edit Jadwal'),
      ),
      body: EditJadwalForm(id, j),
    );
  }
}

// ignore: must_be_immutable
class EditJadwalForm extends StatefulWidget {
  final String id;
  JadwalModel j;
  EditJadwalForm(this.id, this.j, {Key? key}) : super(key: key);

  @override
  EditJadwalFormState createState() {
    return EditJadwalFormState();
  }
}

class EditJadwalFormState extends State<EditJadwalForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nama = TextEditingController();
  late String kelas;
  late String hari;
  final TextEditingController link = TextEditingController();
  final TextEditingController start = TextEditingController();
  final TextEditingController end = TextEditingController();
  final TextEditingController desc = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    nama.text = widget.j.nama;
    kelas = widget.j.kelas;
    hari = widget.j.hari;
    link.text = widget.j.link;
    start.text = widget.j.start;
    end.text = widget.j.end;
    desc.text = widget.j.desc;
    super.initState();
  }

  void submit(BuildContext context) {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      JadwalUtils()
          .putJadwal(widget.id, nama.text, kelas, hari, link.text, start.text,
              end.text, desc.text)
          .then((res) {
        if (res) {
          Navigator.pop(context, true);
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  List<DropdownMenuItem<String>> kelasItems = [
    const DropdownMenuItem(child: Text("10"), value: "10"),
    const DropdownMenuItem(child: Text("11"), value: "11"),
    const DropdownMenuItem(child: Text("12"), value: "12")
  ];

  List<DropdownMenuItem<String>> hariItems = [
    const DropdownMenuItem(child: Text("Senin"), value: "Senin"),
    const DropdownMenuItem(child: Text("Selasa"), value: "Selasa"),
    const DropdownMenuItem(child: Text("Rabu"), value: "Rabu"),
    const DropdownMenuItem(child: Text("Kamis"), value: "Kamis"),
    const DropdownMenuItem(child: Text("Jumat"), value: "Jumat"),
    const DropdownMenuItem(child: Text("Sabtu"), value: "Sabtu"),
    const DropdownMenuItem(child: Text("Minggu"), value: "Minggu"),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: nama,
              decoration: const InputDecoration(
                
                labelText: 'Nama Jadwal',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white70),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama jadwal tidak boleh kosong';
                }
                return null;
              },
            ),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color(0xff1f2251),
              ),
              child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      labelText: 'Kelas',
                      labelStyle: TextStyle(color: Colors.white70)),
                  style: const TextStyle(color: Colors.white70),
                  value: kelas,
                  validator: (value) {
                    if (value == null) {
                      return 'Kelas tidak boleh kosong';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      kelas = newValue!;
                    });
                  },
                  items: kelasItems),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color(0xff1f2251),
              ),
              child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      labelText: 'Hari',
                      labelStyle: TextStyle(color: Colors.white70)),
                  style: const TextStyle(color: Colors.white70),
                  value: hari,
                  validator: (value) {
                    if (value == null) {
                      return 'Hari tidak boleh kosong';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      hari = newValue!;
                    });
                  },
                  items: hariItems),
            ),
            TextFormField(
              controller: start,
              decoration: const InputDecoration(
                labelText: "Jam Mulai",
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white70),
              readOnly: true,
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!);
                    });

                if (pickedTime != null) {
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());

                  String formattedTime = DateFormat('HH:mm').format(parsedTime);

                  setState(() {
                    start.text = formattedTime;
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Jam Mulai tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
              controller: end,
              decoration: const InputDecoration(
                labelText: "Jam Selesai",
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white70),
              readOnly: true,
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!);
                    });

                if (pickedTime != null) {
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());

                  String formattedTime = DateFormat('HH:mm').format(parsedTime);

                  setState(() {
                    end.text = formattedTime;
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Jam Selesai tidak boleh kosong';
                }
                return null;
              },
            ),
            TextFormField(
                controller: link,
                decoration: const InputDecoration(
                  
                  labelText: 'Link',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white70),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Link tidak boleh kosong';
                  }
                  String pattern =
                      r'(^(ftp|http|https):\/\/[^ "]+$)'; //stackoverflow
                  RegExp regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value)) {
                    return 'Link harus valid';
                  }
                  return null;
                }),
            TextFormField(
              controller: desc,
              decoration: const InputDecoration(
                
                labelText: 'Deskripsi',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white70),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  submit(context);
                }
              },
              child: const Text('Update'),
            ),
          ],
        ));
  }
}
