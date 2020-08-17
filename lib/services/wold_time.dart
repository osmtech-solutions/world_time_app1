import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location; //location name for the ui
  String time;  //time in that location
  String flag; //url to an asset flag icon
  String url; //location base url
  bool isDaytime; //true or false

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{

    try{

      //make the request by using http call
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create a date time object
      DateTime dateTime = DateTime.parse(datetime);
      dateTime = dateTime.add(Duration(hours: int.parse(offset)));

      isDaytime = dateTime.hour > 6 && dateTime.hour < 20 ? true : false;  //the time right now is in between 6Am & 8Pm then set true else false
      time = DateFormat.jm().format(dateTime);  //set the time property

    }
    catch(e){
      print('cought error '+e.toString());
      time = 'could not get the time data';
    }

  }

}

