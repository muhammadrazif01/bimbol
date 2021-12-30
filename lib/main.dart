// some part of this code is adapted and modified from flutter api
// (https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)

// Import material package (very important!)
import 'package:flutter/material.dart';
import 'package:pbpbimbol/regisSiswa/screens/register_siswa.dart';

// Run MyApp as main function
void main() => runApp(const MyApp());

// MyApp as main widget container
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title : set menjadi bimbol
      title: 'BIMBOL',

      // theme : atur tema menjadi warna ungu dan font menjadi Raleway
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Raleway',
        unselectedWidgetColor: Colors.white54,
      ),

      // Set home untuk constructor MyStatefulWidget()
      home: const MyStatefulWidget(),
    );
  }
}

// StatefulWidget yang akan diinitiate
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  // Set status untuk StatefulWidget
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

// Buat kelas private untuk state dari StatefulWidget
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // Atur setting untuk state dari Stateful Widget
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontFamily: 'Raleway', fontSize: 30, fontWeight: FontWeight.w900);
  // ignore: unused_field
  static const List<Widget> _widgetOptions = <Widget>[
    // Text untuk bagian mainpage
    Text(
      'This contains button for information',
      style: optionStyle,
    ),

    // Text untuk bagian daftar
    Text(
      'Untuk halaman daftar (not implemented yet here)',
      style: optionStyle,
    ),

    // Text untuk bagian masuk
    Text(
      'Untuk halaman masuk (not implemented yet here)',
      style: optionStyle,
    ),
  ];

  // Define untuk set state saat navbar diklik
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: const Text(
          'BIMBOL\nBimbel di Masa Pandemi',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),

      // Set bg color
      backgroundColor: Colors.purple[300],

      // Set body (sebagian dari kode ini terinspirasi oleh https://youtu.be/4wS5LdXJgEA)
      body: Container(
          padding: const EdgeInsets.all(12),
          child: Stack(fit: StackFit.expand, children: [
            buildBackground(),
            Center(
              child: buildCenterText(),
            ),
            Align(
              alignment: const Alignment(0.0, 1),
              child: buildLikeFB(),
            ),
            Positioned(
              right: 8,
              top: 4,
              child: buildLogo(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return registrasiSiswa();
                }));
              },
              child: Text('Get Started'),
            ),
          ])),

      // Set untuk navbar (sebagian dari kode ini didapat dari Flutter API)
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Mainpage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Daftar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Masuk',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }

  // Widget-widget dibawah diadaptasi, dimodifikasi, dan terinspirasi dari https://youtu.be/4wS5LdXJgEA

  // Buat background
  Widget buildBackground() => ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Opacity(
          opacity: 0.8,
          child: Image.asset(
            'assets/image/adobeproject1.png',
            fit: BoxFit.fitHeight,
          ),
        ),
      );

  // Buat tulisan center
  Widget buildCenterText() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'BIMBOL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: const Text(
              'Sebuah Solusi Mudah dan Aman di Masa Pandemi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );

  // Build like us on FB
  Widget buildLikeFB() => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite, color: Colors.red),
            SizedBox(width: 8),
            Text(
              'Likes Us on Facebook!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  // Build logo UI
  Widget buildLogo() => IconButton(
        icon: const ImageIcon(
          AssetImage('assets/image/logoui.png'),
          color: Colors.yellow,
        ),
        onPressed: () {},
      );
}
