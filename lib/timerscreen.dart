import 'dart:async';
import 'package:countdown_timer/ButtonWidget.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  final int? finaltime;

  TimerScreen({this.finaltime = 60});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int seconds = 60;
  Timer? timer; // timer object

  @override
  void initState() {
    super.initState();
    seconds = widget.finaltime!;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Back"),
        ),
        backgroundColor: Colors.grey[850],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimer(),
                SizedBox(height: 80.0),
                buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTimer() {
    int time = widget.finaltime!;
    return Container(
      height: 200.0,
      width: 200.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: seconds / time,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: Colors.greenAccent,
            strokeWidth: 12,
          ),
          Center(child: buildTime()),
        ],
      ),
    );
  }

  Widget buildTime() {
    return Text(
      "${intToTimeLeft(seconds)}".toString(),
      style: TextStyle(
          fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hourLeft =
        h.toString().length < 2 ? "0" + h.toString() : h.toString();
    String minuteLeft =
        m.toString().length < 2 ? "0" + m.toString() : m.toString();
    String secondsLeft =
        s.toString().length < 2 ? "0" + s.toString() : s.toString();
    String result = "$hourLeft:$minuteLeft:$secondsLeft";
    return result;
  }

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        // setState untuk update UI
        setState(() {
          seconds--;
        });
      } else {
        if (seconds == 0) {
          Navigator.pop(context);
          stopTimer();
        } else {
          stopTimer(reset: false);
        }
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    setState(() {
      timer!.cancel(); // stop timer (pause timer)
    });
  }

  void resetTimer() {
    int time = widget.finaltime!;
    setState(() {
      seconds = time;
    });
  }

  Widget buildButton() {
    final bool isRunning =
        timer == null ? false : timer!.isActive; // cek apakah timer masih aktif
    final bool isCompleted = (seconds == 0 ||
        seconds == widget.finaltime); //if seconds = 0/60, then true

    //if (isRunning == true || isCompleted == false)
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(
          text: isRunning ? "Pause" : "Resume",
          onClicked: () {
            if (isRunning) {
              stopTimer(reset: false);
            } else {
              startTimer(reset: false);
            }
          },
        ),
        SizedBox(
          width: 20.0,
        ),
        ButtonWidget(
          text: "Cancel",
          onClicked: () {
            stopTimer();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
