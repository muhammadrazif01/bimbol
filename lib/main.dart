// import material package needed for this file
import 'package:flutter/material.dart';
import 'forum/screens/root.dart' as forum;
import 'screens/homepage.dart' as homepage;
import 'screens/screen_for_login.dart' as loginpage;
import 'regisSiswa/screens/regis_siswa.dart' as regissiswa;

// run MyApp as main function
void main() => runApp(const MyApp());

// MyApp as main widget container
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Override build method for this class
  @override
  Widget build(BuildContext context) {
    // Using material app, set the title, theme, font and what goes inside it
    return MaterialApp(
      title: 'BIMBOL',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Raleway',
        primaryColor: const Color(0xff171941),
        secondaryHeaderColor: const Color(0xffe14eca),
      ),
      home: const MyStatefulWidget(),
    );
  }
}

// initiate stateful widget
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

// create the actual state
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // initiatializing for bottom navbar
  int _selectedIndex = 0;

  // ignore: unused_field
  static const List<Widget> _widgetOptions = <Widget>[
    // mainpage
    homepage.HomePage(),

    // daftar guru
    Text(
      'Untuk halaman daftar guru (not implemented yet here)',
      style: TextStyle(color: Colors.white),
    ),

    // daftar siswa
    regissiswa.RegistrasiSiswa(),

    // masuk
    loginpage.LoginScreen(),

    // jadwal
    Text(
      'Untuk halaman jadwal (not implemented yet here)',
      style: TextStyle(color: Colors.white),
    ),

    // booking
    Text(
      'Untuk halaman booking (not implemented yet here)',
      style: TextStyle(color: Colors.white),
    ),

    forum.ForumRoot(),

    // testimoni
    Text(
      'Untuk halaman testimoni (not implemented yet here)',
      style: TextStyle(color: Colors.white),
    ),
  ];

  // define state-setting when a navbar is clicked
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // override the build method for this class
  @override
  Widget build(BuildContext context) {
    // using scaffold, set everything such as app bar, bg color, body, and etc
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BIMBOL\nBimbel di Masa Pandemi',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),

      backgroundColor: const Color(0xff171941),

      body: _widgetOptions[_selectedIndex],

      // set the navbar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            label: 'Pendaftaran Guru',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Pendaftaran Siswa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Masuk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paste),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize_outlined),
            label: 'Testimoni',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}
