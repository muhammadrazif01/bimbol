import 'package:flutter/material.dart';
import '../models/jadwal_model.dart';
import 'package:intl/intl.dart';

class AddJadwal extends StatelessWidget {
  const AddJadwal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Tambah Jadwal'),
      ),
      body: const AddJadwalForm(),
    );
  }
}

// Create a Form widget.
class AddJadwalForm extends StatefulWidget {
  const AddJadwalForm({Key? key}) : super(key: key);

  @override
  AddJadwalFormState createState() {
    return AddJadwalFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddJadwalFormState extends State<AddJadwalForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<AddJadwalFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nama = TextEditingController();
  // final TextEditingController kelas = TextEditingController();
  late String kelas;
  late String hari;
  final TextEditingController link = TextEditingController();
  final TextEditingController start = TextEditingController();
  final TextEditingController end = TextEditingController();
  final TextEditingController desc = TextEditingController();
  bool _isLoading = false;

  void submit(BuildContext context) {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      JadwalUtils()
          .postJadwal(nama.text, kelas, hari, link.text, start.text, end.text,
              desc.text)
          .then((res) {
        if (res) {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => Employee()), (route) => false);
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
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: nama,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
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
              decoration: const InputDecoration(labelText: "Jam Mulai", labelStyle: TextStyle(color: Colors.white70),),
              style: const TextStyle(color: Colors.white70),
              readOnly:
                  true, //set it true, so that user will not able to edit text
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
                  // print(pickedTime.format(context)); //output 10:51 PM
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  // print(parsedTime); //output 1970-01-01 22:53:00.000
                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                  // print(formattedTime); //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    start.text = formattedTime; //set the value of text field.
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
              decoration: const InputDecoration(labelText: "Jam Selesai", labelStyle: TextStyle(color: Colors.white70),),
              style: const TextStyle(color: Colors.white70),
              readOnly:
                  true, //set it true, so that user will not able to edit text
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
                  // print(pickedTime.format(context)); //output 10:51 PM
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  // print(parsedTime); //output 1970-01-01 22:53:00.000
                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                  // print(formattedTime); //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    end.text = formattedTime; //set the value of text field.
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
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pinkAccent,
                    ),
                  ),
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
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                labelText: 'Deskripsi',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white70),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  submit(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ));
  }
}
