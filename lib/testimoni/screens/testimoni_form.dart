// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import '../api.dart';
import '../models/testimoni.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class TestimoniFormScreen extends StatefulWidget {
  Testimoni testi;

  TestimoniFormScreen({Key? key, required this.testi}) : super(key: key);

  @override
  _TestimoniFormScreenState createState() => _TestimoniFormScreenState();
}

class _TestimoniFormScreenState extends State<TestimoniFormScreen> {
  bool _isLoading = false;
  final ApiService _apiService = ApiService();
  bool _isFieldNamaValid = false;
  bool _isFieldKelasValid = false;
  bool _isFieldTestimoniValid = false;
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerKelas = TextEditingController();
  final TextEditingController _controllerTestimoni = TextEditingController();

  @override
  void initState() {
    if (widget.testi.id != 0) {
      _isFieldNamaValid = true;
      _controllerNama.text = widget.testi.nama;
      _isFieldKelasValid = true;
      _controllerKelas.text = widget.testi.kelas;
      _isFieldTestimoniValid = true;
      _controllerTestimoni.text = widget.testi.testimoni;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.testi.id == 0 ? "Tambahkan Testimoni" : "Update Testimoni",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child:Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildTextFieldNama(),)
                ),
                Center(
                  child:Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildTextFieldKelas(),)
                ),
                Center(
                  child:Container(
                    padding: const EdgeInsets.all(8.0),
                    child:  _buildTextFieldTestimoni(),)
                ),
   
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text(
                     widget.testi.id == 0
                          ? "Tambah".toUpperCase()
                          : "Update".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldNamaValid == false ||
                          _isFieldKelasValid == false ||
                          _isFieldTestimoniValid == false ||
                          !_isFieldNamaValid ||
                          !_isFieldKelasValid ||
                          !_isFieldTestimoniValid) {
                        _scaffoldState.currentState!.showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String nama = _controllerNama.text.toString();
                      String kelas = _controllerKelas.text.toString();
                      String testimoni = _controllerTestimoni.text.toString();
                      Testimoni testi =
                          Testimoni(nama: nama, kelas: kelas, testimoni: testimoni);
                      if (widget.testi.id == 0) {
                        _apiService.createTestimoni(testi).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState!.context, true);
                          } else {
                            _scaffoldState.currentState!.showSnackBar(const SnackBar(
                              content: Text("Tambah data failed"),
                            ));
                          }
                        });
                      } else {
                        testi.id = widget.testi.id;
                        _apiService.updateTestimoni(testi).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState!.context, true);
                          } else {
                            _scaffoldState.currentState!.showSnackBar(const SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: const <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldNama() {
    
    return TextField(
      controller: _controllerNama,
      keyboardType: TextInputType.text,
      style: const TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        
        hintText: "Contoh: Edogawa Conan",
        hintStyle: const TextStyle( color: Colors.white70,),
        labelText: "Nama Lengkap",
        labelStyle: const TextStyle( color: Colors.white70,),
        icon: const Icon(Icons.person, color: Colors.white70,),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)),
            fillColor: Colors.white70,
        errorText: _isFieldNamaValid == false || _isFieldNamaValid
            ? null
            : "Nama Lengkap is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamaValid) {
          setState(() => _isFieldNamaValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldKelas() {
    
    return TextField(
      controller: _controllerKelas,
      keyboardType: TextInputType.text,
      style: const TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: "Contoh: 12 IPA, 11 IPS",
        hintStyle: const TextStyle( color: Colors.white70,),
        labelText: "Kelas",
        labelStyle: const TextStyle( color: Colors.white70,),
        icon: const Icon(Icons.school, color: Colors.white70,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)),
            fillColor: Colors.white70,
        errorText: _isFieldKelasValid == false || _isFieldKelasValid
            ? null
            : "Kelas is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldKelasValid) {
          setState(() => _isFieldKelasValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldTestimoni() {
    return TextField(
      controller: _controllerTestimoni,
      minLines: 6, 
      keyboardType: TextInputType.multiline,
      style: const TextStyle(color: Colors.white70),
      maxLines: null,
      decoration: InputDecoration(
        labelText: "Testimoni",
        labelStyle: const TextStyle( color: Colors.white70,),
        icon: const Icon(Icons.reviews, color: Colors.white70,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)),
            fillColor: Colors.white70,
        errorText: _isFieldTestimoniValid == false || _isFieldTestimoniValid
            ? null
            : "Testimoni is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTestimoniValid) {
          setState(() => _isFieldTestimoniValid = isFieldValid);
        }
      },
    );
  }
}
