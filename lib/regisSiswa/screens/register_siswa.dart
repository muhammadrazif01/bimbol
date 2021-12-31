import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pbpbimbol/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

Future<http.Response> registFlutter(
    String email,
    String username,
    String pass1,
    String pass2,
    String fullname,
    DateTime birthdate,
    String gender,
    String address,
    bool agree,
    String grade,
    List<String> subjects,
    String payment,
    String phone) async {
  final response = await http.post(
    Uri.parse('https://tk-pbp-a01.herokuapp.com/auth/signup-siswa'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<dynamic, dynamic>{
      'email': email,
      'username': username,
      'password1': pass1,
      'password2': pass2,
      'nama_lengkap': fullname,
      'tanggal_lahir': birthdate.toString().split(' ')[0],
      'jenis_kelamin': gender,
      'alamat': address,
      'agree': agree.toString(),
      'kelas': grade,
      'mata_pelajaran': subjects,
      'payment': payment,
      'nomor_telefon': phone,
    }),
  );
  return response;
}

class registrasiSiswa extends StatefulWidget {
  const registrasiSiswa({Key? key}) : super(key: key);

  @override
  _registrasiSiswaState createState() => _registrasiSiswaState();
}

class _registrasiSiswaState extends State<registrasiSiswa> {
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String name = "";
  String email = "";
  String password1 = "";
  String password2 = "";
  String phone = "";
  DateTime birthdate = DateTime.now();
  String grade = "";
  List<String> subjects = [];
  bool temp = false;
  bool mate = false;
  bool fis = false;
  bool bio = false;
  bool kim = false;
  bool indo = false;
  bool ing = false;
  bool eko = false;
  bool geo = false;
  bool sos = false;
  bool sej = false;
  String address = "";
  String gender = "";
  String payment = "";
  bool agree = false;

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BIMBOL"),
          centerTitle: true,
        ),
        body: Container(
          color: Color.fromARGB(255, 23, 25, 65),
          child: SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        "Registration\nStudent",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Text("Username*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (String value) {
                              username = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white54,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          Text("Fullname*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (String value) {
                              name = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white54,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fullname tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          Text("Email*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (String value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.white54,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              } else if (!EmailValidator.validate(value)) {
                                return "Email tidak valid";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          Text("Password*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            onChanged: (String value) {
                              password1 = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white54,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          Text("Password Confirmation*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            onChanged: (String value) {
                              password2 = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white54,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password Confirmation tidak boleh kosong';
                              } else if (value != password1) {
                                return 'Password tidak sama';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          Text("Telephone Number*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (String value) {
                              phone = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.white54,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Telephone Number tidak boleh kosong';
                              } else if (_isNumeric(value) == false) {
                                return "Telephone Number harus berisi numeric";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          Text("Birthdate*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: birthdate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now())
                                    .then(
                                  (value) {
                                    setState(() {
                                      birthdate = value!;
                                    });
                                  },
                                );
                              },
                              child: Text("Pick Birthdate")),
                          SizedBox(height: 30),
                          Text("Grade*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          RadioListTile(
                              value: "10",
                              title: Text("10",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 14)),
                              groupValue: grade,
                              onChanged: (String? value) {
                                setState(() {
                                  grade = value!;
                                });
                              }),
                          RadioListTile(
                              value: "11",
                              title: Text("11",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 14)),
                              groupValue: grade,
                              onChanged: (String? value) {
                                setState(() {
                                  grade = value!;
                                });
                              }),
                          RadioListTile(
                              value: "12",
                              title: Text("12",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 14)),
                              groupValue: grade,
                              onChanged: (String? value) {
                                setState(() {
                                  grade = value!;
                                });
                              }),
                          SizedBox(height: 30),
                          Text("Subjects*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: mate,
                              title: Text("Matematika",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  mate = value!;
                                });

                                if (mate == true) {
                                  subjects.add("Matematika");
                                } else {
                                  subjects.remove("Matematika");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: fis,
                              title: Text("Fisika",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  fis = value!;
                                });

                                if (fis == true) {
                                  subjects.add("Fisika");
                                } else {
                                  subjects.remove("Fisika");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: bio,
                              title: Text("Biologi",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  bio = value!;
                                });

                                if (bio == true) {
                                  subjects.add("Biologi");
                                } else {
                                  subjects.remove("Biologi");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: kim,
                              title: Text("Kimia",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  kim = value!;
                                });

                                if (kim == true) {
                                  subjects.add("Kimia");
                                } else {
                                  subjects.remove("Kimia");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: indo,
                              title: Text("B.Indonesia",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  indo = value!;
                                });

                                if (indo == true) {
                                  subjects.add("B.Indonesia");
                                } else {
                                  subjects.remove("B.Indonesia");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: ing,
                              title: Text("B.Inggris",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  ing = value!;
                                });

                                if (ing == true) {
                                  subjects.add("B.Inggris");
                                } else {
                                  subjects.remove("B.Inggris");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: eko,
                              title: Text("Ekonomi",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  eko = value!;
                                });

                                if (eko == true) {
                                  subjects.add("Ekonomi");
                                } else {
                                  subjects.remove("Ekonomi");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: geo,
                              title: Text("Geografi",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  geo = value!;
                                });

                                if (geo == true) {
                                  subjects.add("Geografi");
                                } else {
                                  subjects.remove("Geografi");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: sos,
                              title: Text("Sosiologi",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  sos = value!;
                                });

                                if (sos == true) {
                                  subjects.add("Sosiologi");
                                } else {
                                  subjects.remove("Sosiologi");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: sej,
                              title: Text("Sejarah",
                                  style: TextStyle(color: Colors.white54)),
                              onChanged: (value) {
                                setState(() {
                                  sej = value!;
                                });

                                if (sej == true) {
                                  subjects.add("Sejarah");
                                } else {
                                  subjects.remove("Sejarah");
                                }

                                if (subjects != null) {
                                  print(subjects);
                                }
                              }),
                          SizedBox(height: 30),
                          Text("Address*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            maxLines: 4,
                            onChanged: (String value) {
                              address = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              prefixIcon: Icon(
                                Icons.home,
                                color: Colors.white54,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Adress tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          Text("Gender*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          RadioListTile(
                              value: "p",
                              title: Text("Pria",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 14)),
                              groupValue: gender,
                              onChanged: (String? value) {
                                setState(() {
                                  gender = value!;
                                });
                              }),
                          RadioListTile(
                              value: "w",
                              title: Text("Wanita",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 14)),
                              groupValue: gender,
                              onChanged: (String? value) {
                                setState(() {
                                  gender = value!;
                                });
                              }),
                          SizedBox(height: 30),
                          Text("Payment Details*",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white54)),
                          RadioListTile(
                              value: "CASH",
                              title: Text("Cash",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 14)),
                              groupValue: payment,
                              onChanged: (String? value) {
                                setState(() {
                                  payment = value!;
                                });
                              }),
                          RadioListTile(
                              value: "CHECK",
                              title: Text("Check",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 14)),
                              groupValue: payment,
                              onChanged: (String? value) {
                                setState(() {
                                  payment = value!;
                                });
                              }),
                          RadioListTile(
                              value: "CARD",
                              title: Text("Card",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 14)),
                              groupValue: payment,
                              onChanged: (String? value) {
                                setState(() {
                                  payment = value!;
                                });
                              }),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Text("I agree to the terms and condition",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(225, 224, 79, 204))),
                              Checkbox(
                                value: agree,
                                onChanged: (bool? value) {
                                  setState(() {
                                    agree = value!;
                                  });
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 70),
                        ],
                      ),
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState!;
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );

                                      form.save();

                                      registFlutter(
                                              email,
                                              username,
                                              password1,
                                              password2,
                                              name,
                                              birthdate,
                                              gender,
                                              address,
                                              agree,
                                              grade,
                                              subjects,
                                              payment,
                                              phone)
                                          .then((value) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MyStatefulWidget();
                                        }));
                                      });
                                    }
                                  },
                                  child: Text('Get Started',
                                      style: TextStyle(fontSize: 15)),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    minimumSize: Size(250, 50),
                                  )),
                            ]),
                      ),
                    ]),
              )),
        ));
  }
}
