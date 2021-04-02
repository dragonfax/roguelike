import 'package:flutter/material.dart';
import 'arena.dart';
import 'sprites.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await readTiles();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          // child: ArenaWidget(Arena())),
          child: LevelEditor(),
    );
  }
}
