import 'package:flutter/material.dart';
import 'package:rps/screens/play_screen.dart';
import 'package:rps/widgets/pdwe_raised_button.dart';

class StartScreen extends StatefulWidget {
  static const routeName = '/start';

  final socket;
  StartScreen(this.socket);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _roomNameController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Spiel eröffnen')),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Raum eröffnen..'),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {},
                    controller: _roomNameController,
                    decoration: InputDecoration(labelText: 'Raum ID'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {},
                    controller: _userNameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                PdweRaisedButton(() async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => PlayScreen(
                        widget.socket,
                        {
                          'room': _roomNameController.text,
                          'name': _userNameController.text,
                        },
                      ),
                    ),
                  );
                }, 'erstellen')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
