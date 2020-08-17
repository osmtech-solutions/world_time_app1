import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {

    //get the data passed from loading screen
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments ;

    //set the background image, background color, and background text
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.green[300] : Colors.indigo;
    Color txtColor = data['isDaytime'] ? Colors.black : Colors.grey[300];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120,0,0),
            child: Column(
              children:<Widget> [
                FlatButton.icon(
                    onPressed:() async {
                      dynamic result =  await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          "isDaytime": result['isDaytime'],
                          "flag": result['flag']
                        };
                      });
                      },
                    icon: Icon(Icons.edit_location, color: txtColor),
                    label: Text('Edit location', style: TextStyle(color: txtColor))),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        color: txtColor,
                        fontSize: 28.0,
                        letterSpacing: 2.0
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  data['time'],
                  style: TextStyle(
                    color: txtColor,
                    fontSize: 60,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}