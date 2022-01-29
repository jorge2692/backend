import 'package:flutter/material.dart';

class EspUpdatePage extends StatefulWidget {
  @override
  _EspUpdatePageState createState() => _EspUpdatePageState();
}

class _EspUpdatePageState extends State<EspUpdatePage> {
  bool isSwitched = false;
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esp 00003'),
      ),
      body: Center(
        child: Column(
          children: [
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),  Switch(
              value: isSwitch,
              onChanged: (value) {
                setState(() {
                  isSwitch = value;
                });
              },
            ),
          ],

        ),
      ),    );
  }
}



