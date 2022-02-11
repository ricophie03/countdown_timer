import 'package:countdown_timer/timerscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectTime extends StatefulWidget {
  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  int? hour;
  int? minute;
  int? seconds;
  int? finaltime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text("Timer App"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  SizedBox(width: 30.0),
                  TimePicker(
                    maxValue: 23,
                    minValue: 0,
                    flexi: 1,
                    onChanged: (value) {
                      hour = value * 3600;
                      print(hour);
                    },
                  ),
                  Text("J",
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
                  SizedBox(width: 50.0),
                  TimePicker(
                    maxValue: 59,
                    minValue: 0,
                    flexi: 1,
                    onChanged: (value) {
                      minute = value * 60;
                      print(minute);
                    },
                  ),
                  Text("M",
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
                  SizedBox(width: 50.0),
                  TimePicker(
                    maxValue: 59,
                    minValue: 0,
                    flexi: 1,
                    onChanged: (value) {
                      seconds = value;
                      print(seconds);
                    },
                  ),
                  Text("D",
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  finaltime = (hour ?? 0) + (minute ?? 0) + (seconds ?? 0);
                  if (finaltime == 0) {
                    var msg = Fluttertoast.showToast(
                        msg: "Setting your timer.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        textColor: Colors.black,
                        fontSize: 16.0);
                    msg;
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TimerScreen(
                        finaltime: finaltime,
                      );
                    }));
                  }
                },
                child: Text("Start Timer!")),
          ],
        ),
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  int? maxValue;
  int? minValue;
  int? flexi;
  final Function(dynamic value) onChanged;

  TimePicker(
      {this.maxValue, this.minValue, this.flexi, required this.onChanged});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: widget.flexi!,
      child: Container(
        child: WheelChooser.integer(
          unSelectTextStyle: TextStyle(color: Colors.white),
          onValueChanged: widget.onChanged,
          maxValue: widget.maxValue!,
          minValue: widget.minValue!,
          isInfinite: true,
          magnification: 1.2,
          selectTextStyle: TextStyle(color: Colors.blue),
          itemSize: 30.0,
          listHeight: 300.0,
          listWidth: 50.0,
        ),
      ),
    );
  }
}
