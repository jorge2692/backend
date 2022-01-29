import 'package:flutter/material.dart';


class Prueba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return Center(
        child: MyStatefulWidget(),
    );
  }
}
bool _state = false;

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new_rounded, color: _state == false ? Colors.red
                : Colors.green, size: 30,),
            tooltip: 'Control de Encendido de Equipo',
            onPressed: () {
              setState(() {
                _state = !_state;
              });
            },
          ),

          Text(_state == false ? 'State: OFF' : 'State: ON')

        ],
      ),
    );
  }
}

