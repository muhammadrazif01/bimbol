// Import material package (very important!)
import 'package:flutter/material.dart';

// create class homepage to initialize homepage
class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _MyHomePageState();
}

// create class for the state of the homepage
class _MyHomePageState extends State<HomePage> {

  // override the build method and use scaffold to set everything that goes inside it
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.purple[300],

      body: Container(
          padding: EdgeInsets.all(12),
          child: Stack(
              fit: StackFit.expand,
              children: [
                buildBackground(),
                Center(
                  child: buildCenterText(),
                ),
                Positioned(
                  right: 8,
                  top: 4,
                  child: buildLogo(),
                ),
              ]
          )
      ),

    );
  }

  // widget to set background using picture
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

  // widget to create the center text
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

  // widget to build UI logo in top of the screen
  Widget buildLogo() => IconButton(
    icon: const ImageIcon(
      AssetImage('assets/image/logoui.png'),
      color: Colors.yellow,
    ),
    onPressed: () {},
  );
}