import 'dart:convert';
import 'package:flutter/material.dart';
import '../api.dart';
import '../models/testimoni.dart';
import '../screens/testimoni_form.dart';
import 'package:http/http.dart' as http;

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class TestimoniScreen extends StatefulWidget {
  const TestimoniScreen({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/testimoni';
  
  @override
  _TestimoniScreenState createState() => _TestimoniScreenState();
}

class _TestimoniScreenState extends State<TestimoniScreen> {
  late BuildContext context;
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    var testi = Testimoni(testimoni: "", nama: "", kelas: "");

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldState,
      appBar: AppBar(
        title: const Text(
          'Pengalaman dan Testimoni dari Siswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
            fontFamily: 'DancingScript1',
            color: Colors.white70,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
      
      child: FutureBuilder(
        future: apiService.getTesti(),
        builder: (BuildContext context, AsyncSnapshot<List<Testimoni>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Testimoni> testimonial = snapshot.data!;
            return _buildListView(testimonial);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        
      ),

      
    ),
    floatingActionButton: FloatingActionButton(
      
        onPressed: () async {
          var result = await Navigator.push(_scaffoldState.currentContext!, 
          MaterialPageRoute(builder: (context) { 
            return TestimoniFormScreen(testi: testi);
            }));
          if (result != null) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
    );
    

    
  }

  Widget _buildListView(List<Testimoni> testimonial) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemCount: testimonial.length,
        itemBuilder: (context, index) {
          Testimoni testi = testimonial[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              color: const Color(0xff1f2251),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(title: Text(
                      testi.testimoni,
                      style: TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white70),
                    ),
                    subtitle:
                        Text(testi.nama + ' kelas ' + testi.kelas,
                        style: TextStyle(color: Colors.white70)),),
                    // Text(
                    //   testi.testimoni,
                    //   style: TextStyle(
                    //       fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    // ),
                    //   Text(testi.nama + ' kelas ' + testi.kelas,
                    //   style: TextStyle(color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Warning"),
                                    content: Text("Apa anda yakin ingin menghapus testimoni ini?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService.deleteTestimoni(testi.id).then((isSuccess) {
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(content: Text("Delete data success")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(content: Text("Delete data failed")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return TestimoniFormScreen(testi: testi);
                            }));
                            if (result != null) {
                              setState(() {});
                            }
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        
      ),
    );
  }
}
