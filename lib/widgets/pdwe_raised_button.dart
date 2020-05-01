import 'package:flutter/material.dart';

class PdweRaisedButton extends StatelessWidget {
  final Function _onClicked;
  final String _text;

  PdweRaisedButton(this._onClicked, this._text);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onClicked,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            _text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
