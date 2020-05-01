import 'package:flutter/material.dart';
import 'package:rps/screens/join_screen.dart';
import 'package:rps/screens/start_sceen.dart';
import 'package:rps/widgets/pdwe_raised_button.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final socket = IO.io('http://192.168.178.102:3000', <String, dynamic>{
    'transports': ['websocket'],
    'force new connection': true,
    'auto connect': false
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'rps 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {
        JoinScreen.routeName: (ctx) => JoinScreen(socket),
        StartScreen.routeName: (ctx) => StartScreen(socket),
        // PlayScreen.routeName: (ctx) => PlayScreen(),
      },
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
    return Scaffold(
      appBar: AppBar(
        title: Text('RPS 2'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(JoinScreen.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 200,),
              PdweRaisedButton(() {
                Navigator.of(context).pushNamed(JoinScreen.routeName);
              }, 'Spiel beitreten'),
              SizedBox(height: 20,),
              // PdweRaisedButton(() {
              //   Navigator.of(context).pushNamed(StartScreen.routeName);
              // }, 'Spiel erstellen'),
            ],
          ),
        ),
      ),
    );
  }
}
