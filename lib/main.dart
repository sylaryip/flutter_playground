import 'package:flutter/material.dart';
import 'package:playground/custom_paint_chaos.dart';
import 'package:playground/sketch_pad.dart';

import 'skew_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home());
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playground')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Sketch Pad'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SketchPad(),
              ));
            },
          ),
          ListTile(
            title: const Text('Chaos'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CustomPaintChaos(),
              ));
            },
          ),
          ListTile(
            title: const Text('Skew'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SkewPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
