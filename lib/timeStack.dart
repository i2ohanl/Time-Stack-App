import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeStack extends StatefulWidget {
  const TimeStack({super.key});

  @override
  TimeStackState createState() => TimeStackState();
}

class TimeStackState extends State<TimeStack> {
  //Date Values for checking if variables need to be updated
  // ignore: prefer_typing_uninitialized_variables
  var prevDate;
  var currDate = DateTime.now().day.toInt();

  //Variables to manage heights
  // ignore: prefer_typing_uninitialized_variables
  var dailyTotalPos;
  // ignore: prefer_typing_uninitialized_variables
  var dailyTotalNeg;
  // ignore: prefer_typing_uninitialized_variables
  var producitve;
  // ignore: prefer_typing_uninitialized_variables
  var unproductive; 

  //Variable initialisation function called as soon as entered into call stack
  @override
  void initState() {
    super.initState();
    getData();
  }
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getInt('prevDate') == null) {
      prefs.setInt('dailyTotalPos', 0);
      prefs.setInt('dailyTotalNeg', 0);
      prefs.setInt('productive', 0);
      prefs.setInt('unproductive', 0);
      prefs.setInt('prevDate', currDate);
    }
    setState(() {
      prevDate = prefs.getInt('prevDate');
      if(prevDate == currDate) {
        dailyTotalNeg = dailyTotalPos = unproductive = producitve = 0;
        prefs.setInt('dailyTotalPos', 0);
        prefs.setInt('dailyTotalNeg', 0);
        prefs.setInt('productive', 0);
        prefs.setInt('unproductive', 0);
        prefs.setInt('prevDate', currDate);
      } else {
        dailyTotalPos = prefs.getInt('dailyTotalPos');
        dailyTotalNeg = prefs.getInt('dailyTotalNeg');
        producitve = prefs.getInt('productive');
        unproductive = prefs.getInt('unproductive');
      }
      if(producitve == null) {
        print('Null');
      } else {
        print(producitve.toString());
      }
    });
  }

  setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('dailyTotalPos', dailyTotalPos);
    prefs.setInt('dailyTotalNeg', dailyTotalNeg);
    prefs.setInt('productive', producitve);
    prefs.setInt('unproductive', unproductive);
  }
  //Checks for first boot, prevDate set to null if so
  //if prev date same as curr date (data still of current date) retrive info as is
  //else reset info, set prevdate to new date and reset the stack

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const max = 250.0;
    final day = DateTime.now().day.toInt();
    final month = DateTime.now().month.toInt();
    var dayDisplay = '';

    if(day < 10){
      dayDisplay = '${dayDisplay}0$day/';
    } else {
      dayDisplay = '$dayDisplay$day/';
    }
    if(month < 10){
      dayDisplay = '${dayDisplay}0$month\n';
    } else {
      dayDisplay = '$dayDisplay$month\n';
    }
    if(producitve!=null){
    // ignore: sized_box_for_whitespace
    print('Productive not null: '+producitve.toString());
    if(unproductive!=null){
      print('unProductive not null: '+unproductive.toString());
    }else{
      print('unproductive null');
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0.0,
            child: Container(
              height: height,
              width: width*11/20,
              color: Colors.white,
              child: Stack(
                children : <Widget>[
                  Positioned(
                    top: height/2,
                    left: ((width*11/20)/2) - 55,
                    child: Square(color: Colors.blue.shade100, height: (dailyTotalNeg*10).toDouble(), width: 100.0,),
                  ),
                  Positioned(
                    top: height/2,
                    left: ((width*11/20)/2) - 55,
                    child: Square(color: Colors.blue, height: (unproductive*10).toDouble(), width: 100.0,),
                  ),
                  Positioned(
                    top: height/2,
                    left: ((width*11/20)/2) - 80,
                    child: const Square(color: Colors.black, height: 1.0, width: 150.0,),
                  ),
                  Positioned(
                    top: height/2 - 250,
                    left: ((width*11/20)/2) - 55,
                    child: const Square(color: Colors.orange, height: max , width: 100.0,),
                  ),
                  Positioned(
                    top: height/2 - 250,
                    left: ((width*11/20)/2) - 55,
                    child: Square(color: Colors.orange[200], height: max - 100.0, width: 100.0,),
                  ),
                  Positioned(
                   top: height/2 -250,
                   left: ((width*11/20)/2) - 55,
                   child: const Square(color: Colors.white, height: 90.0, width: 100.0,),
                  ),
                  Positioned(
                    top: height/2 + max,
                    left: ((width*11/20)/2) - 55,
                    child: Square(color: Colors.grey[500], height: 1.0, width: 120.0,),
                  ),
                  Positioned(
                    top: height/2 - max,
                    left: ((width*11/20)/2) - 55,
                    child: Square(color: Colors.grey[500], height: 1.0, width: 120.0,),
                  ),
                ]
              ),
            ),
          ),
          Positioned (
            left: width * 11 / 20,
            child: Container(
              color: Colors.blueGrey[50],
              height: height,
              width: width * 9 / 20,
              child: Stack(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: dayDisplay),
                        TextSpan(text: DateFormat('EEEE').format(DateTime.now()))
                      ]
                    ),
                  ),

                  //Increase productive button
                  Positioned(
                    top: 200.0,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if(unproductive >= 0) {
                            unproductive = unproductive - 1;
                          } else {
                            producitve = producitve + 1;
                          }
                          dailyTotalPos = dailyTotalPos + 1;
                          setData();
                        });
                      },
                      child: const Icon(Icons.add, color: Colors.orange,),
                    ),
                  ),

                  //Increase unproductive button
                  Positioned(
                    top: 300.0,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if(producitve > 0) {
                            producitve = producitve - 1;
                          } else {
                            unproductive = unproductive + 1;
                          }
                          dailyTotalNeg = dailyTotalNeg + 1;
                          setData();
                        });
                      },
                      child: Icon(Icons.add, color: Colors.blue,),
                    ),
                  ),
                ],
              )
            ),
          ),
        ],
      )
    );
    } else {
      return const Text('Loading');
    }
  }
}


//Temporary container to visualise the wireframe
class Square extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final color;
  // ignore: prefer_typing_uninitialized_variables
  final height;
  // ignore: prefer_typing_uninitialized_variables
  final width;
  const Square({super.key,  this.color = const Color.fromARGB(179, 255, 255, 255), this.height, this.width});
  @override
  build(context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}
